import 'dart:html';
import 'dart:math' as Math;

import 'keyboard.dart';
import 'audio.dart';
import 'player.dart';
import 'sprite.dart';
import 'tetris.dart';

List<String> songs = ['media/audio/Avatar- The Legend of Korobeiniki.wav',
					  'media/audio/Chair to Meet You.wav'];

class Game {

	CanvasElement canvas;
	CanvasRenderingContext2D ctx;
	int width, height;

	ImageElement background;

	double lastTime = 0.0;

	Keyboard p1 = new Keyboard();
	Player player1;
	Player player2;

	int currentSong = 0;

	int gameState = 0;


	void getContext() {
		canvas = querySelector("#screen");
		ctx = canvas.getContext("2d");

		width = canvas.width;
		height = canvas.width;

		start();
	}

	void start() {

		Piece.init();
		Sprite.init();

		player1 = new Player(1, ctx, p1, new Controls.player1());
		player2 = new Player(2, ctx, p1, new Controls.player2());
		SoundManager.load(songs, () {
			//SoundManager.play('media/audio/Avatar- The Legend of Korobeiniki.wav');
		});
	}

	void gameLoop(newTime) {

		//calculate delta time (dt) to send to all updated objects
		double dt = (newTime - lastTime) / 1000;
		lastTime = newTime;

		if (p1.isPressed(KeyCode.N, true)) {
			currentSong = (currentSong + 1) % songs.length;
			SoundManager.play(songs[currentSong]);
		}

		if (p1.isPressed(KeyCode.M, true)) {
			if (SoundManager.playing()) {
				SoundManager.stop();
			} else {
				SoundManager.play(songs[currentSong]);
			}
		}

		if (p1.isPressed(KeyCode.P, true)) {
			gameState = 0;
			player1 = new Player(1, ctx, p1, new Controls.player1());
			player2 = new Player(2, ctx, p1, new Controls.player2());
		}

		switch (gameState) {
			case 0:
				player1.update(dt);
				player2.update(dt);

				if (player1.board.finished_rows > 0) {
					player2.board.rowsToAdd = player1.board.finished_rows;
					player1.board.finished_rows = 0;
				}

				if (player2.board.finished_rows > 0) {
					player1.board.rowsToAdd = player2.board.finished_rows;
					player2.board.finished_rows = 0;
				}

				break;
			case 1:
				break;
		}

		// Check if anyone lost
		if (player1.board.didLose() || player2.board.didLose()) gameState = 1;


		Sprite.draw(ctx, "cage", 0.0, 0.0);

		player1.draw();
		player2.draw();

		Sprite.draw(ctx, "tileborder", 422.0, 30.0);

		ctx.fillStyle = "000000";
		ctx.globalAlpha = 0.5;
		ctx.fillRect(442, 50, 140, 360);
		ctx.globalAlpha = 1.0;

		switch (gameState) {
			case 0: break;
			case 1:
				ctx.fillStyle = '#000000';
				ctx.fillRect(312, 284, 400, 200);
				ctx.font = '100px sans-serif';
				ctx.fillStyle = '#FF0000';
				ctx.fillText('GAME OVER', 362, 434, 300);

		}

		double placement = 0.0;
		double scale = 0.70;
		Piece.nextPieces.forEach((e) {
			for(int i=0; i<4; i++) {
				for(int j=0; j<4; j++) {
					if (e.get(i, j) == 1) {
						//ctx.drawImage(current.color, x + (j + col)*blockSize, y + (i + row)*blockSize);
						Sprite.draw(ctx, e.color, 475*(1/scale) + (j)*30.0, 70*(1/scale) + (i + e.row)*30.0 + placement, scale:scale);
					} else if (e.get(i, j) == 2) {
						//ctx.drawImage(magic, x + (j + col)*blockSize, y + (i + row)*blockSize);
						Sprite.draw(ctx, "magic", 475*(1/scale) + (j)*30.0, 70*(1/scale) + (i + e.row)*30.0 + placement, scale:scale);
					}

				}
			}
			placement = placement + 120.0;
		});

		window.animationFrame.then(gameLoop);
	}

}
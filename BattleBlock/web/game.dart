import 'dart:html';
import 'dart:math' as Math;

import 'keyboard.dart';
import 'audio.dart';
import 'player.dart';



class Game {

	CanvasElement canvas;
	CanvasRenderingContext2D ctx;
	int width, height;

	ImageElement background;

	double lastTime = 0.0;

	Keyboard p1 = new Keyboard();
	Player player1;
	Player player2;


	void getContext() {
		canvas = querySelector("#screen");
		ctx = canvas.getContext("2d");

		width = canvas.width;
		height = canvas.width;

		start();
	}

	void start() {
		background = new ImageElement(src:"media/img/background.png");

		player1 = new Player(1, ctx, p1, new Controls.player1());
		player2 = new Player(2, ctx, p1, new Controls.player2());
		SoundManager.load(['media/audio/Robot_Bunny_Hop.wav'], () {
			SoundManager.play('media/audio/Robot_Bunny_Hop.wav');
		});
	}

	void gameLoop(newTime) {

		//calculate delta time (dt) to send to all updated objects
		double dt = (newTime - lastTime) / 1000;
		lastTime = newTime;

		if (p1.isPressed(KeyCode.M, true)) {
			if (SoundManager.playing()) {
				SoundManager.stop();
			} else {
				SoundManager.play('media/audio/Robot_Bunny_Hop.wav');
			}
		}

		player1.update(dt);
		player2.update(dt);

		if (player1.board.finished_rows > 0) {
			player2.board.addRows(player1.board.finished_rows);
			player1.board.finished_rows = 0;
		}

		if (player2.board.finished_rows > 0) {
			player1.board.addRows(player2.board.finished_rows);
			player2.board.finished_rows = 0;
		}

		//clear screen
		//ctx.fillStyle = "#000000";
		//ctx.fillRect(0, 0, canvas.width, canvas.height);

		ctx.drawImage(background, 0, 0);

		player1.draw();
		player2.draw();

		window.animationFrame.then(gameLoop);
	}

}
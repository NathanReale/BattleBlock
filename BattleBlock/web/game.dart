import 'dart:html';

import 'keyboard.dart';
import 'audio.dart';
import 'tetris.dart';
import 'player.dart';

class Game {

	CanvasElement canvas;
	CanvasRenderingContext2D ctx;
	int width, height;

	ImageElement background;

	double lastTime = 0.0;

	Keyboard p1 = new Keyboard();
	Player player;
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

		player = new Player(1, ctx, p1);
		player2 = new Player(2, ctx, p1);
		SoundManager.load(['media/audio/Tetris Theme A- for that game thing .wav'], () {
			SoundManager.play('media/audio/Tetris Theme A- for that game thing .wav');
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
				SoundManager.play('media/audio/Tetris Theme A- for that game thing .wav');
			}
		}

		player.update(dt);
		player2.update(dt);

		//clear screen
		//ctx.fillStyle = "#000000";
		//ctx.fillRect(0, 0, canvas.width, canvas.height);

		ctx.drawImage(background, 0, 0);

		player.draw();
		player2.draw();

		window.animationFrame.then(gameLoop);
	}

}
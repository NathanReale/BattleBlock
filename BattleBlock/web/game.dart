import 'dart:html';

import 'keyboard.dart';
import 'audio.dart';
import 'tetris.dart';
import 'player.dart';

class Game {

	CanvasElement canvas;
	CanvasRenderingContext2D ctx;
	int width, height;

	double lastTime = 0.0;

	Keyboard p1 = new Keyboard();
	Player player;

	void getContext() {
		canvas = querySelector("#screen");
		ctx = canvas.getContext("2d");

		width = canvas.width;
		height = canvas.width;

		start();
	}

	void start() {
		player = new Player(ctx, p1);
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

		//clear screen
		ctx.fillStyle = "#000000";
		ctx.fillRect(0, 0, canvas.width, canvas.height);

		player.draw();

		window.animationFrame.then(gameLoop);
	}

}
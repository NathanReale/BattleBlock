import 'dart:html';
import 'keyboard.dart';
import 'tetris.dart';

class Game {

	CanvasElement canvas;
	CanvasRenderingContext2D ctx;
	int width, height;

	double lastTime = 0.0;

	Keyboard p1 = new Keyboard();
	Tetris player1;

	void getContext() {
		canvas = querySelector("#screen");
		ctx = canvas.getContext("2d");

		width = canvas.width;
		height = canvas.width;

		start();
	}

	void start() {
		player1 = new Tetris(ctx, p1);
	}

	void gameLoop(newTime) {

		//calculate delta time (dt) to send to all updated objects
		double dt = (newTime - lastTime) / 1000;
		lastTime = newTime;

		player1.update(dt);

		//clear screen
		ctx.fillStyle = "#000000";
		ctx.fillRect(0, 0, canvas.width, canvas.height);

		player1.draw();

		window.animationFrame.then(gameLoop);
	}
}
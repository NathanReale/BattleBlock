import 'dart:html';

class Game {

	CanvasElement canvas;
	CanvasRenderingContext2D ctx;

	double lastTime = 0.0;

	void getContext() {
		canvas = querySelector("#screen");
		ctx = canvas.getContext("2d");

		canvas.width = window.innerWidth;
		canvas.height = window.innerHeight;
	}

	void gameLoop(newTime) {

		//calculate delta time (dt) to send to all updated objects
		double dt = (newTime - lastTime) / 1000;
		lastTime = newTime;

		//clear screen
		ctx.fillStyle = "#000000";
		ctx.fillRect(0, 0, canvas.width, canvas.height);

		window.animationFrame.then(gameLoop);
	}
}
import 'dart:html';
import 'tetris.dart';
import 'keyboard.dart';

class Player {

	Tetris board;
	Keyboard keys;

	Player(CanvasRenderingContext2D ctx, this.keys) {
		board = new Tetris(ctx);
	}

	update(dt) {

		board.resetSpeed();

		if(keys.isPressed(37, true)) {
			board.moveLeft();
		}
		else if(keys.isPressed(39, true)) {
			board.moveRight();
		}
		else if(keys.isPressed(40)) {
			board.moveDown();
		}
		board.update(dt);
	}

	draw() {
		board.draw();
	}
}
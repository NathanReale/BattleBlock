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

		if(keys.isPressed(KeyCode.LEFT, true)) {
			board.moveLeft();
		} else if(keys.isPressed(KeyCode.RIGHT, true)) {
			board.moveRight();
		} else if(keys.isPressed(KeyCode.DOWN)) {
			board.moveDown();
		} else if(keys.isPressed(KeyCode.SPACE, true)) {
			board.rotate(1);
		}
		board.update(dt);
	}

	draw() {
		board.draw();
	}
}
import 'dart:html';
import 'tetris.dart';
import 'keyboard.dart';

class Player {

	int player;
	Tetris board;
	Keyboard keys;

	Player(this.player, CanvasRenderingContext2D ctx, this.keys) {
		board = new Tetris(player, ctx);
	}

	update(dt) {

		board.resetSpeed();

 		if(player == 1) {
			if(keys.isPressed(KeyCode.LEFT, true)) {
				board.moveLeft();
			} else if(keys.isPressed(KeyCode.RIGHT, true)) {
				board.moveRight();
			} else if(keys.isPressed(KeyCode.DOWN)) {
				board.moveDown();
			} else if(keys.isPressed(KeyCode.SPACE, true)) {
				board.rotate(1);
			}
 		}
 		else if(player == 2) {
	 		if(keys.isPressed(KeyCode.A, true)) {
				board.moveLeft();
			} else if(keys.isPressed(KeyCode.D, true)) {
				board.moveRight();
			} else if(keys.isPressed(KeyCode.S)) {
				board.moveDown();
			} else if(keys.isPressed(KeyCode.W, true)) {
				board.rotate(1);
			}
 		}

		board.update(dt);
	}

	draw() {
		board.draw();
	}
}
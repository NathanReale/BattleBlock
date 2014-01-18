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
		if(keys.isPressed(37, true)) {
			print('left');
		}
		else if(keys.isPressed(39, true)) {
			print('right!');
		}
		board.update(dt);
	}

	draw() {
		board.draw();
	}
}
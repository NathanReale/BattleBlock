import 'dart:html';
import 'tetris.dart';
import 'keyboard.dart';

class Player {

	int player;
	Tetris board;
	Keyboard keys;

	Controls controls;

	Player(this.player, CanvasRenderingContext2D ctx, this.keys, this.controls) {
		board = new Tetris(player, ctx);
	}

	update(dt) {

		board.resetSpeed();

		if (keys.isAnyPressed(controls[Control.LEFT], true)) {
			board.moveLeft();
		} else if (keys.isAnyPressed(controls[Control.RIGHT], true)) {
			board.moveRight();
		} else if (keys.isAnyPressed(controls[Control.DOWN])) {
			board.moveDown();
		} else if (keys.isAnyPressed(controls[Control.ROT_L], true)) {
			board.rotate(-1);
		} else if (keys.isAnyPressed(controls[Control.ROT_R], true)) {
			board.rotate(1);
		}

// 		if(player == 1) {
//			if(keys.isPressed(KeyCode.LEFT, true)) {
//				board.moveLeft();
//			} else if(keys.isPressed(KeyCode.RIGHT, true)) {
//				board.moveRight();
//			} else if(keys.isPressed(KeyCode.DOWN)) {
//				board.moveDown();
//			} else if(keys.isPressed(KeyCode.SPACE, true)) {
//				board.rotate(1);
//			}
// 		}
// 		else if(player == 2) {
//	 		if(keys.isPressed(KeyCode.A, true)) {
//				board.moveLeft();
//			} else if(keys.isPressed(KeyCode.D, true)) {
//				board.moveRight();
//			} else if(keys.isPressed(KeyCode.S)) {
//				board.moveDown();
//			} else if(keys.isPressed(KeyCode.W, true)) {
//				board.rotate(1);
//			}
// 		}

		board.update(dt);
	}

	draw() {
		board.draw();
	}
}

class Controls {
	Map<Control, List<KeyCode>> _controls;

	Controls.player1() {
		_controls = new Map<Control, List<KeyCode>>();

		_controls[Control.LEFT] = [KeyCode.A];
		_controls[Control.RIGHT] = [KeyCode.D];
		_controls[Control.DOWN] = [KeyCode.S];
		_controls[Control.ROT_L] = [KeyCode.Q];
		_controls[Control.ROT_R] = [KeyCode.E];
		_controls[Control.MAGIC] = [KeyCode.W];
	}

	Controls.player2() {
		_controls = new Map<Control, List<KeyCode>>();

		_controls[Control.LEFT] = [KeyCode.NUM_ONE];
		_controls[Control.RIGHT] = [KeyCode.NUM_THREE];
		_controls[Control.DOWN] = [KeyCode.NUM_TWO];
		_controls[Control.ROT_L] = [KeyCode.NUM_FOUR];
		_controls[Control.ROT_R] = [KeyCode.NUM_SIX];
		_controls[Control.MAGIC] = [KeyCode.NUM_FIVE];
	}

	List<KeyCode> operator[](Control c) => _controls[c];
}

class Control {
	final _value;
	const Control._internal(this._value);
	toString() => '$_value';

	static const LEFT = const Control._internal('Left');
	static const RIGHT = const Control._internal('Right');
	static const DOWN = const Control._internal('Down');
	static const ROT_L = const Control._internal('Rotate Left');
	static const ROT_R = const Control._internal('Rotate Right');
	static const MAGIC = const Control._internal('Magic');
}
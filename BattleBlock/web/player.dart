library player;

import 'dart:html';
import 'tetris.dart';
import 'keyboard.dart';
import 'character.dart';

import 'sprite.dart';

class Player {

	int player;
	Tetris board;
	Keyboard keys;

	Character char;
	Controls controls;

	Player opponent;

	CanvasRenderingContext2D ctx;

	Player(this.player, this.ctx, this.keys, this.controls, this.char) {
		board = new Tetris(player, ctx);
	}

	update(dt) {

		board.resetSpeed();

		if (keys.isAnyPressed(controls[Control.LEFT], true)) {
			board.move(-1);
		} else if (keys.isAnyPressed(controls[Control.RIGHT], true)) {
			board.move(1);
		} else if (keys.isAnyPressed(controls[Control.DOWN])) {
			board.moveDown();
		} else if (keys.isAnyPressed(controls[Control.ROT_L], true)) {
			board.rotate(-1);
		} else if (keys.isAnyPressed(controls[Control.ROT_R], true)) {
			board.rotate(1);
		}

		if (keys.isAnyPressed(controls[Control.MAGIC], true)) {

			switch (board.magic) {
				case 0: break;
				case 1: board.magic -= 1; char.m1(board, opponent.board); break;
				case 2: board.magic -= 2; char.m2(board, opponent.board); break;
				case 3: board.magic -= 3; char.m3(board, opponent.board); break;
				default: board.magic -= 4; char.m4(board, opponent.board); break;
			}

		}

		board.update(dt);
	}

	draw() {
		board.draw();
		ctx.fillStyle = '#000000';
		ctx.strokeStyle = '#000000';
		double x = (player == 1 ? 20.0 : 970.0);
		for (int i = 0; i < board.magic; i++) {
			Sprite.draw(ctx, 'magic', x, 680.0 - (i*30));
		}
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
library tetris;

import 'dart:html';
import 'dart:math' as Math;

import 'keyboard.dart';

part 'piece.dart';

class Tetris {

	double x = 75.0;
	double y = 30.0;
	CanvasRenderingContext2D ctx;

	static const int numRows = 22;
	static const int numCols = 10;
	List<List<int>> board;
	static const int blockSize = 30;

	Keyboard keys;

	Piece current;
	int col = 0;
	double row = 0.0;

	Tetris(this.ctx, Keyboard k) {
		Piece.init();

		board = new List(numRows);
		for(int i=0; i<numRows; i++) {
			board[i] = new List.filled(numCols, 0);
		}

		current = new Piece.random();

	}

	void update(dt) {
		row += dt;
	}

	void draw() {
		ctx.fillStyle = "#FF0000";
		for(int i=0; i<numRows; i++) {
			for(int j=0; j<numCols; j++) {
				if (board[i][j] == 1) {
					ctx.fillRect(x + j*blockSize, y + i*blockSize, blockSize, blockSize);
				}
			}
		}

		for(int i=0; i<4; i++) {
			for(int j=0; j<4; j++) {
				if (current[i][j] == 1) {
					ctx.fillRect((j + col)*blockSize, (i + row)*blockSize, blockSize, blockSize);
				}
			}
		}
	}
}
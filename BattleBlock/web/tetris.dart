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
		row += dt* 4;
		if (!valid()) {
			row -= dt*4;
			merge();
			row = 0.0;
			col = 0;
			current = new Piece.random();
		}

	}

	void draw() {
		ctx.fillStyle = "#FF0000";
		for(int i=0; i<numRows; i++) {
			for(int j=0; j<numCols; j++) {

				if(board[i][j] == 1) {
					ctx.fillStyle = "#FF0000";
					ctx.fillRect(x + j*blockSize, y + i*blockSize, blockSize, blockSize);
				} else if(board[i][j] == 2) {
					ctx.fillStyle = "#FF0000";
					ctx.fillRect(x + j*blockSize, y + i*blockSize, blockSize, blockSize);
				}
			}
		}

		for(int i=0; i<4; i++) {
			for(int j=0; j<4; j++) {
				if (current[i][j] == 1) {
					ctx.fillRect(x + (j + col)*blockSize, y + (i + row)*blockSize, blockSize, blockSize);
				}

			}
		}
	}

	bool valid() {
		int r = row.ceil();

		for(int i=0; i<4; i++) {
			for(int j=0; j<4; j++) {
				if (current[i][j] != 0 && (i + r >= numRows || board[i + r][j + col] != 0)) {
					return false;
				}
			}
		}

		return true;
	}

	void merge() {
		int r = row.ceil();
		for(int i=0; i<4; i++) {
			for(int j=0; j<4; j++) {
				if (current[i][j] != 0) {
					board[i + r][j + col] = current[i][j];
				}
			}
		}
	}

	void add(/*piece*/) {

	}
}
library tetris;

import 'dart:html';
import 'keyboard.dart';

class Tetris {

	double x = 75.0;
	double y = 30.0;
	CanvasRenderingContext2D ctx;

	int numRows = 22;
	int numCols = 10;
	List<List<int>> board = new List(22);
	int blockSize = 30;

	Keyboard keys;

	Tetris(this.ctx, Keyboard k) {
		for(int i=0; i<numRows; i++) {
			board[i] = new List(10);
		}

		for(int i=0; i<numRows; i++) {
			for(int j=0; j<numCols; j++) {
				board[i][j] = 1;
			}
		}
	}

	void update(dt) {

	}

	void draw() {
		ctx.fillStyle = "#FF0000";
		for(int i=0; i<numRows; i++) {
			for(int j=0; j<numCols; j++) {
				ctx.fillRect(x + j*blockSize + j, y + i*blockSize + i, blockSize, blockSize);
			}
		}
	}
}
library tetris;

import 'dart:html';
import 'keyboard.dart';

class Tetris {

	double x = 75.0;
	double y = 30.0;
	CanvasRenderingContext2D ctx;

	static const int numRows = 22;
	static const int numCols = 10;
	List<List<int>> board;
	static const int blockSize = 30;

	Keyboard keys;

	Tetris(this.ctx, Keyboard k) {
		board = new List(numRows);
		for(int i=0; i<numRows; i++) {
			board[i] = new List.filled(numCols, 0);
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
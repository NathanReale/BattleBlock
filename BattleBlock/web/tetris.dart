library tetris;

import 'dart:html';
import 'dart:math' as Math;

part 'piece.dart';

class Tetris {

	double x = 75.0;
	double y = 30.0;
	CanvasRenderingContext2D ctx;

	static const int numRows = 22;
	static const int numCols = 10;
	List<List<int>> board;
	static const int blockSize = 30;

	ImageElement blue;

	Piece current;
	int col = 0;
	double row = 0.0;
	int speed = 2;

	bool stopped = false;
	double stoppedTimer = 0.0;
	double maxStopTime = 0.5;

	Tetris(this.ctx) {
		Piece.init();

		blue = new ImageElement(src:"media/img/blue.png");

		board = new List(numRows);
		for(int i=0; i<numRows; i++) {
			board[i] = new List.filled(numCols, 0);
		}

		current = new Piece.random();
	}

	void update(dt) {

		if(!stopped) {
			row += dt*speed;
			if (!valid()) {
				row -= dt*speed;
				row = row.ceil() * 1.0;
				stopped = true;
				stoppedTimer = maxStopTime;
			}
		}
		else {
			row += dt*speed;
			if(valid()) {
				stopped = false;
				stoppedTimer = 0.0;
			}
			else {
				row -= dt*speed;
				row = row.ceil() * 1.0;
				stoppedTimer -= maxStopTime*dt;
				if(stoppedTimer < 0) {
					stoppedTimer = 0.0;
					stopped = false;
					setPiece();
				}
			}
		}
	}

	void draw() {

		ctx.fillStyle = "#FFFFFF";
		ctx.fillRect(x, y, blockSize*numCols, blockSize*numRows);

		ctx.fillStyle = "#FF0000";
		for(int i=0; i<numRows; i++) {
			for(int j=0; j<numCols; j++) {

				if(board[i][j] == 1) {
					ctx.drawImage(blue, x + j*blockSize, y+i*blockSize);
				} else if(board[i][j] == 2) {
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
				if (current[i][j] != 0 && ((col + j) < 0 || (col + j) >= numCols ||  i + r >= numRows || board[i + r][j + col] != 0)) {
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

	void setPiece() {
		merge();
		row = 0.0;
		col = 0;
		current = new Piece.random();
	}

	void moveLeft() {
		col -= 1;
		if(!valid()) {
			col += 1;
		}
	}

	void moveRight() {
		col += 1;
		if(!valid()) {
			col -= 1;
		}
	}

	void moveDown() {
		if(stopped) {
			stoppedTimer = 0.0;
			stopped = false;
			setPiece();
		} else {
			speed = 12;
		}
	}

	void resetSpeed() {
		speed = 2;
	}
}
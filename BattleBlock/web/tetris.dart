library tetris;

import 'dart:html';
import 'dart:math' as Math;

part 'piece.dart';

Math.Random rand = new Math.Random();

class Tetris {

	double x = 75.0;
	double y = 50.0;
	CanvasRenderingContext2D ctx;

	int player;

	static const int numRows = 22;
	static const int numCols = 10;
	List<List<int>> board;
	static const int blockSize = 30;

	ImageElement playerColor;
	ImageElement blue, red, magic;

	Piece current;
	int col = 0;
	double row = 0.0;
	int speed = 2;

	bool stopped = false;
	double stoppedTimer = 0.0;
	double maxStopTime = 0.5;

	int finished_rows = 0;
	int rowsToAdd = 0;

	Tetris(this.player, this.ctx) {
		Piece.init();

		blue = new ImageElement(src:"media/img/blue.png");
		red = new ImageElement(src:"media/img/red.png");
		magic = new ImageElement(src:"media/img/magic.png");

		board = new List<List<int>>();
		for(int i=0; i<numRows; i++) {
			board.add(new List.filled(numCols, 0));
		}

		if(player == 2) {
			playerColor = red;
			x = ctx.canvas.width - blockSize*numCols - x;
			y = 50.0;
		} else {
			playerColor = blue;
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
					ctx.drawImage(playerColor, x + j*blockSize, y+i*blockSize);
				} else if(board[i][j] == 2) {
					ctx.fillRect(x + j*blockSize, y + i*blockSize, blockSize, blockSize);
				}
			}
		}

		for(int i=0; i<4; i++) {
			for(int j=0; j<4; j++) {
				if (current[i][j] == 1) {
					ctx.drawImage(current.color, x + (j + col)*blockSize, y + (i + row)*blockSize);
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
		checkForRows();
		addRows(rowsToAdd);
		row = 0.0;
		col = 0;
		current = new Piece.random();
	}

	void checkForRows() {
		List<int> full = new List();
		for(int i=0; i<numRows; i++) {
			bool thisRow = true;
			for(int j=0; j<numCols; j++) {
				if(board[i][j] != 1 && board[i][j] != 2) {
					thisRow = false;
					break;
				}
			}
			if(thisRow) {
				full.add(i);
			}
		}
		full.forEach((e) {
			board.removeAt(e);
			board.insert(0, new List.filled(numCols, 0));
			finished_rows++;
		});
	}

	void move(int dir) {
		col += dir;
		if(!valid()) {
			col -= dir;
		}
	}

	void moveDown() {
		if(stopped) {
			stoppedTimer = 0.0;
			stopped = false;
			setPiece();
		} else {
			speed = 24;
		}
	}

	void rotate(int dir) {
		current.rotate(dir);
		if (!valid()) current.rotate(-dir);
	}

	void resetSpeed() {
		speed = 2;
	}

	void addRows(int count) {
		List<int> newRow = new List.filled(numCols, 1);
		newRow[rand.nextInt(numCols)] = 0;

		for (int i = 0; i < count; i++) {
			board.removeAt(0);

			board.insert(numRows - 1, newRow.toList());
		}
	}
}
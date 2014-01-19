library tetris;

import 'dart:html';
import 'dart:math' as Math;
import 'sprite.dart';

part 'piece.dart';

Math.Random rand = new Math.Random();

class Tetris {

	double x = 75.0;
	double y = 50.0;
	CanvasRenderingContext2D ctx;

	int player;

	static const int boardHeight = 24;
	static const int numRows = 22;
	static const int numCols = 10;
	List<List<int>> board;
	static const int blockSize = 30;

	String playerColor;

	Piece current;
	int col = 3;
	double row = 0.0;
	int speed = 2;

	bool stopped = false;
	double stoppedTimer = 0.0;
	double maxStopTime = 0.5;

	int finished_rows = 0;
	int rowsToAdd = 0;

	int magic = 0;
	static const int MAGIC_CAP = 4;

	Tetris(this.player, this.ctx) {

		board = new List<List<int>>();
		for(int i=0; i<numRows; i++) {
			board.add(new List.filled(numCols, 0));
		}

		if(player == 2) {
			playerColor = "red";
			x = ctx.canvas.width - blockSize*numCols - x;
			y = 50.0;
		} else {
			playerColor = "blue";
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

		for(int i=0; i<numRows; i++) {
			for(int j=0; j<numCols; j++) {

				if(board[i][j] == 1) {
					//ctx.drawImage(playerColor, x + j*blockSize, y+i*blockSize);
					Sprite.draw(ctx, playerColor, x + j*blockSize, y + i*blockSize);
				} else if(board[i][j] == 2) {
					//ctx.drawImage(magic, x + j*blockSize, y + i*blockSize);
					Sprite.draw(ctx, "magic", x + j*blockSize, y + i*blockSize);
				}
			}
		}

		for(int i=0; i<4; i++) {
			for(int j=0; j<4; j++) {
				if (current.get(i, j) == 1) {
					//ctx.drawImage(current.color, x + (j + col)*blockSize, y + (i + row)*blockSize);
					Sprite.draw(ctx, current.color, x + (j + col)*blockSize, y + (i + row)*blockSize);
				} else if (current.get(i, j) == 2) {
					//ctx.drawImage(magic, x + (j + col)*blockSize, y + (i + row)*blockSize);
					Sprite.draw(ctx, "magic", x + (j + col)*blockSize, y + (i + row)*blockSize);
				}

			}
		}
	}

	bool valid() {
		int r = row.ceil();

		for(int i=0; i<4; i++) {
			for(int j=0; j<4; j++) {
				if (current.get(i, j) != 0 && ((col + j) < 0 || (col + j) >= numCols ||  i + r >= numRows || board[i + r][j + col] != 0)) {
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
				if (current.get(i, j) != 0) {
					board[i + r][j + col] = current.get(i, j);
				}
			}
		}
	}

	void setPiece() {
		merge();
		checkForRows();
		if(rowsToAdd > 0) {
			addRows(rowsToAdd);
		}
		row = 0.0;
		col = 3;
		current = Piece.getNextPiece();
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
			magic = board[e].fold(magic, (prev, elm) => prev + (elm == 2 ? 1 : 0));
			if (magic > MAGIC_CAP) magic = MAGIC_CAP;
			board.removeAt(e);
			board.insert(0, new List.filled(numCols, 0));
			finished_rows++;
		});

	}

	int findTopRow() {
		for(int i=0; i<numRows; i++) {
			for(int j=0; j<numCols; j++) {
				if(board[i][j] == 1 || board[i][j] == 2) {
					return i;
				}
			}
		}
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
		rowsToAdd = 0;
	}

	void removeRows(int count) {
		for (int i = 0; i < count; i++) {
			board.removeLast();
			board.insert(0, new List<int>.filled(numCols, 0));
		}
	}

	bool didLose() {
		for (int i = 0; i < numCols; i++) {
			if (board[1][i] != 0) return true;
		}

		return false;
	}
}
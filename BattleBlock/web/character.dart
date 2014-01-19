import 'tetris.dart';


void magic_drop(Tetris cur, Tetris opp) {
	cur.removeRows(4);
}

void magic_slide(Tetris cur, Tetris opp) {
	cur.removeRows(2);
	opp.addRows(2);
}

void magic_steal(Tetris cur, Tetris opp) {
	opp.board.forEach((e) {
		for(int i=0; i<Tetris.numCols; i++) {
			if(e[i] == 2) {
				if(cur.magic < 4) {
					cur.magic++;
				}
				e[i] = 1;
			}
		}
	});
}

void magic_queue(Tetris cur, Tetris opp) {
	cur.magic = opp.magic;
	opp.magic = 0;
}

void magic_split(Tetris cur, Tetris opp) {
	for(int i=cur.findTopRow(); i<Tetris.numRows; i++) {
		for(int j=2; j<=4; j++) {
			cur.board[i][j-2] = cur.board[i][j];
			cur.board[i][j] = 0;
		}

		for(int j = Tetris.numCols-1; j>=Tetris.numCols-4; j--) {
			cur.board[i][j] = cur.board[i][j-2];
			cur.board[i][j-2] = 0;
		}
	}
}

void magic_invert(Tetris cur, Tetris opp) {

	for(int i=opp.findTopRow(); i<Tetris.numRows; i++) {
		for(int j=0; j<Tetris.numCols; j++) {
			if(opp.board[i][j] == 1) {
				opp.board[i][j] = 0;
			} else if(opp.board[i][j] == 0) {
				opp.board[i][j] = 1;
			}
		}
	}
}

void magic_nuke(Tetris cur, Tetris opp) {
	for (int r = 0; r < Tetris.numRows; r++) {
		for (int c = 0; c < Tetris.numCols; c++) {
			if (opp.board[r][c] == 1 && rand.nextDouble() > 0.5) {
				opp.board[r][c] = 0;
			}
		}
	}
}


class Character {
	final Function m1, m2, m3, m4;
	const Character(this.m1, this.m2, this.m3, this.m4);

	static const BILL = const Character(magic_drop, magic_split, magic_steal, magic_invert);
	static const TED = const Character(magic_slide, magic_drop, magic_queue, magic_nuke);
}


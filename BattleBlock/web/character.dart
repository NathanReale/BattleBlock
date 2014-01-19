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


class Character {
	final Function m1, m2, m3, m4;
	const Character(this.m1, this.m2, this.m3, this.m4);

	static const BILL = const Character(magic_drop, magic_slide, magic_steal, magic_drop);
}
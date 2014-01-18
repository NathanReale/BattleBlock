part of tetris;

class Piece {
	static const numPieces = 7;
	static List<Piece> pieces = new List<Piece>(numPieces);
	static Math.Random rand = new Math.Random();

	static init() {
		pieces[0] = new Piece([new Rotation([[0, 0, 0, 0], [1, 1, 1, 1], [0, 0, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0]])]);

		pieces[1] = new Piece([new Rotation([[0, 0, 0, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 0, 0, 0]])]);

		pieces[2] = new Piece([new Rotation([[0, 0, 0, 0], [0, 0, 1, 1], [0, 1, 1, 0], [0, 0, 0, 0]]),
	   						   new Rotation([[0, 1, 0, 0], [0, 1, 1, 0], [0, 0, 1, 0], [0, 0, 0, 0]])]);

		pieces[3] = new Piece([new Rotation([[0, 0, 0, 0], [0, 1, 1, 0], [0, 0, 1, 1], [0, 0, 0, 0]]),
	  						   new Rotation([[0, 0, 1, 0], [0, 1, 1, 0], [0, 1, 0, 0], [0, 0, 0, 0]])]);

		pieces[4] = new Piece([new Rotation([[0, 1, 0, 0], [0, 1, 1, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 1, 0, 0], [1, 1, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 1, 0, 0], [1, 1, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
	   						   new Rotation([[0, 0, 0, 0], [1, 1, 1, 0], [0, 1, 0, 0], [0, 0, 0, 0]])]);

		pieces[5] = new Piece([new Rotation([[0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 1, 0], [1, 1, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[1, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 0, 0], [1, 1, 1, 0], [1, 0, 0, 0], [0, 0, 0, 0]])]);

		pieces[6] = new Piece([new Rotation([[0, 1, 0, 0], [0, 1, 0, 0], [1, 1, 0, 0], [0, 0, 0, 0]]),
		  					   new Rotation([[0, 0, 0, 0], [1, 1, 1, 0], [0, 0, 1, 0], [0, 0, 0, 0]]),
			 				   new Rotation([[0, 1, 1, 0], [0, 1, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
				  			   new Rotation([[1, 0, 0, 0], [1, 1, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]])]);
	}

	List<Rotation> rotations;
	int rotation, row, col;

	Piece(this.rotations);

	Piece.random() {
		this.rotations = pieces[rand.nextInt(numPieces)].rotations;
		this.rotation = 0;
		this.row = this.col = 0;
	}

	void rotate(int x) {
		this.rotation = (this.rotation + x) % this.rotations.length;
	}

	operator [](int i) => this.rotations[this.rotation][i];

}

class Rotation {
	List<List<int>> board;

	operator [](int i) => board[i];

	Rotation(this.board);
}
part of tetris;

class Piece {
	static const numPieces = 7;
	static List<Piece> pieces = new List<Piece>(numPieces);
	static List<String> colors = new List<String>(numPieces);
	static Math.Random rand = new Math.Random();

	static List<Piece> nextPieces = new List<Piece>();

	static int pieceCounter = 0;
	static const int MAGIC_FREQ = 4;

	static init() {
		pieces[0] = new Piece([new Rotation([[0, 0, 0, 0], [1, 2, 1, 1], [0, 0, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 1, 0, 0], [0, 2, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0]]),
							   new Rotation([[0, 0, 0, 0], [1, 1, 2, 1], [0, 0, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 1, 0], [0, 0, 1, 0], [0, 0, 2, 0], [0, 0, 1, 0]])]);

		pieces[1] = new Piece([new Rotation([[0, 0, 0, 0], [0, 2, 1, 0], [0, 1, 1, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 0, 0], [0, 1, 2, 0], [0, 1, 1, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 0, 0], [0, 1, 1, 0], [0, 1, 2, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 0, 0], [0, 1, 1, 0], [0, 2, 1, 0], [0, 0, 0, 0]])]);

		pieces[2] = new Piece([new Rotation([[0, 0, 0, 0], [0, 2, 1, 0], [1, 1, 0, 0], [0, 0, 0, 0]]),
	   						   new Rotation([[1, 0, 0, 0], [1, 2, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
		 					   new Rotation([[0, 0, 0, 0], [0, 1, 1, 0], [1, 2, 0, 0], [0, 0, 0, 0]]),
			   				   new Rotation([[1, 0, 0, 0], [2, 1, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]])]);

		pieces[3] = new Piece([new Rotation([[0, 0, 0, 0], [1, 2, 0, 0], [0, 1, 1, 0], [0, 0, 0, 0]]),
	  						   new Rotation([[0, 0, 1, 0], [0, 2, 1, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 0, 0], [1, 1, 0, 0], [0, 2, 1, 0], [0, 0, 0, 0]]),
			  				   new Rotation([[0, 0, 1, 0], [0, 1, 2, 0], [0, 1, 0, 0], [0, 0, 0, 0]])]);

		pieces[4] = new Piece([new Rotation([[0, 1, 0, 0], [0, 2, 1, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 1, 0, 0], [1, 2, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 1, 0, 0], [1, 2, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
	   						   new Rotation([[0, 0, 0, 0], [1, 2, 1, 0], [0, 1, 0, 0], [0, 0, 0, 0]])]);

		pieces[5] = new Piece([new Rotation([[0, 1, 0, 0], [0, 2, 0, 0], [0, 1, 1, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 1, 0], [1, 2, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[1, 1, 0, 0], [0, 2, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
							   new Rotation([[0, 0, 0, 0], [1, 2, 1, 0], [1, 0, 0, 0], [0, 0, 0, 0]])]);

		pieces[6] = new Piece([new Rotation([[0, 1, 0, 0], [0, 2, 0, 0], [1, 1, 0, 0], [0, 0, 0, 0]]),
		  					   new Rotation([[0, 0, 0, 0], [1, 2, 1, 0], [0, 0, 1, 0], [0, 0, 0, 0]]),
			 				   new Rotation([[0, 1, 1, 0], [0, 2, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]),
				  			   new Rotation([[1, 0, 0, 0], [1, 2, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0]])]);


		colors[0] = "cream";
		colors[1] = "yellow";
		colors[2] = "pink";
		colors[3] = "green";
		colors[4] = "purple";
		colors[5] = "red";
		colors[6] = "blue";

		for(int i=0; i<4; i++) {
			nextPieces.add(new Piece.random());
		}

		print("pieces in queue: $nextPieces.length");
	}

	List<Rotation> rotations;
	int rotation, row, col;
	bool magic;

	String color;

	Piece(this.rotations);

	Piece.random() {
		int whichPiece = rand.nextInt(numPieces);

		this.rotations = pieces[whichPiece].rotations;
		this.color = colors[whichPiece];
		this.rotation = 0;
		this.row = 0;
		this.col = 4;

		this.magic = (++pieceCounter % MAGIC_FREQ == 0);

	}

	static Piece getNextPiece() {
		Piece next = nextPieces.removeAt(0);
		nextPieces.add(new Piece.random());

		return next;
	}

	void rotate(int x) {
		this.rotation = (this.rotation + x) % this.rotations.length;
	}

	int get(int row, int col) {
		int val = this.rotations[this.rotation][row][col];
		if (val == 2 && !magic) val = 1;
		return val;
	}

}

class Rotation {
	List<List<int>> board;

	operator [](int i) => board[i];

	Rotation(this.board);

	Rotation clone() {
		List<List<int>> b = new List<List<int>>();
		board.forEach((row) { b.add(row.toList()); });
		return new Rotation(b);
	}
}
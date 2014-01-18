part of tetris;

class Piece {
	static const numPieces = 7;
	static List<Piece> pieces = new List<Piece>(numPieces);
	static List<ImageElement> colors = new List<ImageElement>(numPieces);
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


		colors[0] = new ImageElement(src:"media/img/cream.png");
		colors[1] = new ImageElement(src:"media/img/yellow.png");
		colors[2] = new ImageElement(src:"media/img/pink.png");
		colors[3] = new ImageElement(src:"media/img/green.png");
		colors[4] = new ImageElement(src:"media/img/purple.png");
		colors[5] = new ImageElement(src:"media/img/red.png");
		colors[6] = new ImageElement(src:"media/img/blue.png");
	}

	List<Rotation> rotations;
	int rotation, row, col;

	ImageElement color;
	int whichPiece;

	Piece(this.rotations);

	Piece.random() {
		whichPiece = rand.nextInt(numPieces);
		this.rotations = pieces[whichPiece].rotations;
		this.color = colors[whichPiece];
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
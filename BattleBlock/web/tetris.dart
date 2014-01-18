import 'dart:html';

class Tetris {

	double x, y;
	CanvasRenderingContext2D ctx;

	int numRows = 22;
	int numCols = 10;
	List<List<int>> board = new List(22);

	Tetris() {
		for(int i=0; i<numRows; i++) {
			board[i] = new List(10);
		}
	}

	void Update(dt) {

	}

	void Draw() {

	}

	void AddToBottom(num howMany) {

	}
}
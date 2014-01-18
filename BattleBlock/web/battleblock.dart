import 'dart:html';
import 'game.dart';

void main() {

	var game = new Game();

	game.getContext();

	window.animationFrame.then(game.gameLoop);
}

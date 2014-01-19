import 'dart:html';
import 'game.dart';

void main() {

	var game = new Game();

	game.init();

	window.animationFrame.then(game.gameLoop);
}

import 'dart:html';
import 'game.dart';

void main() {
  
  var game = new Game();
  
  game.GetContext();
  
  window.animationFrame.then(game.GameLoop);
}

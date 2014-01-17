import 'dart:html';

class Game {
  
  var canvas;
  CanvasRenderingContext2D ctx;
  
  num lastTime;
  
  void GetContext() {
    canvas = querySelector("#screen");
    ctx = canvas.getContext("2d");
  }
  
  void GameLoop(newTime) {
    
    //calculate delta time (dt) to send to all updated objects
    num dt = (newTime - lastTime) / 1000;
    lastTime = newTime;
    
    //clear screen
    ctx.fillStyle = "#000000";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    
    window.animationFrame.then(GameLoop);
  }
}
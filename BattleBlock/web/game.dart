import 'dart:html';
import 'dart:web_audio';

import 'keyboard.dart';
import 'tetris.dart';
import 'player.dart';

class Game {

	CanvasElement canvas;
	CanvasRenderingContext2D ctx;
	int width, height;

	double lastTime = 0.0;

	Keyboard p1 = new Keyboard();
	Player player;
	Player player2;

	void getContext() {
		canvas = querySelector("#screen");
		ctx = canvas.getContext("2d");

		width = canvas.width;
		height = canvas.width;

		start();
	}

	void start() {
		player = new Player(1, ctx, p1);
		player2 = new Player(2, ctx, p1);
		playAudio('media/audio/Tetris Theme A- for that game thing .wav');
	}

	void gameLoop(newTime) {

		//calculate delta time (dt) to send to all updated objects
		double dt = (newTime - lastTime) / 1000;
		lastTime = newTime;

		player.update(dt);
		player2.update(dt);

		//clear screen
		ctx.fillStyle = "#000000";
		ctx.fillRect(0, 0, canvas.width, canvas.height);

		player.draw();
		player2.draw();

		window.animationFrame.then(gameLoop);
	}

	void playAudio(String filename) {
		AudioContext audioContext = new AudioContext();
	  	GainNode gainNode = audioContext.createGainNode();


		HttpRequest.request(filename, responseType: 'arraybuffer').then((response) {
			audioContext.decodeAudioData(response.response).then((buffer) {
				playSound() {
					AudioBufferSourceNode source = audioContext.createBufferSource();
					source.loop = true;
					source.connectNode(gainNode, 0, 0);
					gainNode.connectNode(audioContext.destination, 0, 0);
					source.buffer = buffer;
					source.start(0);
				}
				playSound();
			});
		});
	}
}
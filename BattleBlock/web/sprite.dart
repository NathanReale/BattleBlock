library sprite;

import 'dart:html';

class Sprite {

	static Map<String, ImageElement> images = new Map<String, ImageElement>();
	static int numLoaded = 0;

	static int numImages;
	static bool allLoaded = false;

	static init() {
		images["red"] = new ImageElement(src:"media/img/red.png");
		images["green"] = new ImageElement(src:"media/img/green.png");
		images["blue"] = new ImageElement(src:"media/img/blue.png");
		images["pink"] = new ImageElement(src:"media/img/pink.png");
		images["yellow"] = new ImageElement(src:"media/img/yellow.png");
		images["cream"] = new ImageElement(src:"media/img/cream.png");
		images["magic"] = new ImageElement(src:"media/img/magic.png");
		images["purple"] = new ImageElement(src:"media/img/purple.png");

		images["cage"] = new ImageElement(src:"media/img/background.png");
		images["boards"] = new ImageElement(src:"media/img/boards.png");
		images["gameover"] = new ImageElement(src:"media/img/gameover.png");
		images["winner"] = new ImageElement(src:"media/img/winner.png");
		images["loser"] = new ImageElement(src:"media/img/loser.png");

		images["charles"] = new ImageElement(src:"media/img/Charles.png");
		images["goat"] = new ImageElement(src:"media/img/Goat_Charles.png");

		numImages = images.length;

		images.forEach((k, v) {
			v.onLoad.listen((e) {
		    	numLoaded++;
				if (numLoaded == numImages) {
					print("all loaded");
					allLoaded = true;
				}
		    });
		});
	}

	static draw(CanvasRenderingContext2D ctx, String name, double x, double y, {double scale}) {
		if(allLoaded) {
			if(scale == null) {
				ctx.drawImage(images[name], x, y);
			} else {
				ctx.scale(scale, scale);
				ctx.drawImage(images[name], x, y);
				ctx.resetTransform();
			}

		}
	}
}
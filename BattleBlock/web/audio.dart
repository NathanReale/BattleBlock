library audio;

import 'dart:html';
import 'dart:web_audio';

class Sound {

	String filename;

	AudioBufferSourceNode source;

	Sound(AudioBuffer buffer, AudioContext ctx, GainNode gain) {
		source = ctx.createBufferSource();
		source.loop = true;
		source.connectNode(gain, 0, 0);
		gain.connectNode(ctx.destination, 0, 0);
		source.buffer = buffer;

	}

	void play() {
		source.start(0);
	}

	void stop() {
		source.stop(0);
	}
}

class SoundManager {

	static Map<String, AudioBuffer> _sounds = new Map<String, AudioBuffer>();
	static AudioContext ctx = new AudioContext();
	static GainNode gainNode = ctx.createGainNode();

	static Sound _current;

	static void load(List<String> files, Function callback) {
		int waiting = files.length;

		files.forEach((filename) {
			HttpRequest.request(filename, responseType: 'arraybuffer').then((response) {
				ctx.decodeAudioData(response.response).then((buffer) {
					_sounds[filename] = buffer;
					if (--waiting == 0) callback();
				});
			});
		});
	}

	static Sound play(String filename) {
		stop();
		_current = new Sound(_sounds[filename], ctx, gainNode);
		_current.play();
	}

	static void stop() {
		if (_current != null) {
			_current.stop();
			_current = null;
		}
	}

	static bool playing() {
		return _current != null;
	}


}
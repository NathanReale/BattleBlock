library keyboard;

import 'dart:html';

class Keyboard {
	Map<int, int> _keys = new Map<int, int>();

  	Keyboard() {
    	window.onKeyDown.listen((KeyboardEvent e) {
      		// If the key is not set yet, set it with a timestamp.
      		if (!_keys.containsKey(e.keyCode))
        		_keys[e.keyCode] = e.timeStamp;
    	});

    	window.onKeyUp.listen((KeyboardEvent e) {
      		_keys.remove(e.keyCode);
    	});
  	}

	bool isPressed(int keyCode, [bool clear = false]) {
  		var ret = _keys.containsKey(keyCode);
		if (clear) _keys.remove(keyCode);
		return ret;
  	}

	bool isAnyPressed(List<KeyCode> keys, [bool clear = false]) {
		bool ret = false;
		keys.forEach((key) {
			if (isPressed(key, clear)) ret = true;
		});

		return ret;
	}

}
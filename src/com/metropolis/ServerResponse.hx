package com.metropolis;

import openfl.utils.Object;
import openfl.events.Event;

/**
 * Server Response
 * @author Asim
 */
class ServerResponse extends Event {
	
    private var _data:Object;

	public function new(type:String, data:Object = null, bubbles:Bool = false, cancelable:Bool = false) {
		
        super(type, bubbles, cancelable);

		_data = data;
	}

	public override function clone():ServerResponse {

		return new ServerResponse(type, _data, bubbles, cancelable);

	}

	public override function toString():String {

		return "[AppEvents type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " data=" + _data + "]";

	}

	public function getData():Object {

		return _data;

	}
}

package com.metropolis;

import openfl.events.Event;
import openfl.utils.Object;

/**
 * Server Response
 * @author Asim
 */
class ServerResponse extends Event
{

	private var _resource:Resource<Object, Dynamic>;

	public var resource(get, set):Resource<Object, Dynamic>;

	function get_resource():Resource<Object, Dynamic>
	{
		return _resource;
	}

	function set_resource(data:Resource<Object, Dynamic>):Resource<Object, Dynamic>
	{
		return _resource = data;
	}

	public function new(type:String, data:Resource<Object, Dynamic> = null, bubbles:Bool = false, cancelable:Bool = false)
	{

		super(type, bubbles, cancelable);

		_resource = data;
	}

	public override function clone():ServerResponse
	{

		return new ServerResponse(type, _resource, bubbles, cancelable);

	}

	public override function toString():String
	{

		return "[AppEvents type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " resource=" + _resource + "]";

	}

}

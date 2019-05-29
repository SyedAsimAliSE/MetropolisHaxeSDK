package com.valour.classes.events;
import openfl.events.Event;

/**
 * ...
 * @author Asim
 */
class AppEvent extends Event
{

	public var data(get, null):Dynamic = null;
	function get_data():Dynamic { return data; }

	public function new(type:String, customData:Dynamic = null, bubbles:Bool=false, cancelable:Bool=false)
	{
		this.data = customData;
		super(type, bubbles, cancelable);
	}

	public override function clone ():AppEvent
	{
		return new AppEvent (type, data, bubbles, cancelable);
	}

	public override function toString ():String
	{
		return "[AppEvent type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " data=" + data + "]";
	}

}
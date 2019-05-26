package com.valour.classes.data;

/**
 * ...
 * @author Asim
 */
class AppConfigs
{

	private var _token:String;

	public var token(get, set):String;

	function get_token():String
	{
		return _token;
	}

	function set_token(token:String):String
	{
		return _token = token;
	}

	public function new(token:String = null)
	{
		this._token = token;
	}

}
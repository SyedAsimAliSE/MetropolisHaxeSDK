package com.valour.classes.service;
import com.metropolis.Metropolis;

/**
 * ...
 * @author Asim
 */
class RemoteHelper
{
	@:isVar public var PKG(get, set):String = null;
	function get_PKG():String { return PKG; }
	function set_PKG(value:String):String { return PKG = value; }

	@:isVar public var baseUrl(get, set):String = null;
	function get_baseUrl():String { return baseUrl; }
	function set_baseUrl(value:String):String { return baseUrl = value; }

	public var server(get, null):Metropolis = null;
	function get_server():Metropolis  { return server; }

	public function new(_baseUrl:String = null, _PKG:String = null )
	{
		baseUrl = _baseUrl;
		PKG = _PKG;
	}
	
	public function setup():Void
	{
		server = new Metropolis(baseUrl);
	}
	
}
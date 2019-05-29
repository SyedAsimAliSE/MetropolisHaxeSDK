package com.metropolis.internals;
import com.metropolis.internals.Request;

/**
 * ...
 * @author Asim
 */
class RequestBase
{

	@:isVar public var serverUrl(get, set):String = null;
	@:isVar public var request(get, set):Request = null;
	@:isVar public var token(get, set):String = null;

	function get_serverUrl():String { return serverUrl;	}
	function set_serverUrl(value:String):String { return serverUrl = value;	}

	function get_request():Request { return request; }
	function set_request(value:Request):Request { return request = value; }

	function get_token():String { return token; }
	function set_token(value:String):String { return token = value;	}

	public function new(_serverUrl:String, _token:String = null)
	{

		serverUrl = _serverUrl;

		token = _token;
	}

}
package com.metropolis;

import com.metropolis.internals.Request;
import com.metropolis.internals.Resource;
import openfl.utils.Object;

using com.metropolis.internals.EventHandler;

/**
 * Metropolis Haxe SDK
 * @author Asim
 *
 * Wrapper for the Request
 */
class Metropolis
{
	public var onServerResponse = new EventHandler<Resource<Object, String> ->Void>();

	@:isVar public var serverURL(get, set):String = null;
	@:isVar public var accessToken(get, set):String = null;

	function get_serverURL():String { return serverURL;	}
	function set_serverURL(value:String):String { return serverURL = value;	}

	function get_accessToken():String { return accessToken;	}
	function set_accessToken(value:String):String { return accessToken = value;	}

	private var _tinkRequest:TinkRequest = null;

	private var _isRequestInProgress:Bool = false;

	public function new(_serverUrl:String = null)
	{
		serverURL = _serverUrl;

		_tinkRequest = new TinkRequest(serverURL, accessToken);
		_tinkRequest.onRequestComplete += function(resource:Resource<Object, String>)
		{
			_isRequestInProgress = false;
			
			this.onServerResponse.dispatch(resource);
		};

	}

	public function createTinkerGQLReq(request:Request):Void
	{
		if (!_isRequestInProgress)
		{
			_isRequestInProgress = true;

			_tinkRequest.token = accessToken;

			_tinkRequest.createRequest(request);
		}
	}

	public function dispose()
	{
		_tinkRequest = null;
	}

}

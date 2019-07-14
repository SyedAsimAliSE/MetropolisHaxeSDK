package com.metropolis;

import com.metropolis.internals.Request;
import com.metropolis.internals.Resource;
import openfl.utils.Object;
import promhx.Deferred;
import promhx.Promise;

/**
 * Metropolis Haxe SDK
 * @author Asim
 *
 * Wrapper for the Request
 */
class Metropolis
{

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
	}

	public function createTinkerGQLReq(request:Request):Promise<Resource<Object, String>>
	{
		var deferred = new Deferred();

		if (!_isRequestInProgress)
		{
			_isRequestInProgress = true;

			_tinkRequest.token = accessToken;

			_tinkRequest.createRequest(request).then(function (resource:Resource<Object, String>)
			{
				_isRequestInProgress = false;

				deferred.resolve(resource);

			}).catchError(function(error)
			{
				deferred.throwError(error);
			});
		}

		return new Promise(deferred);
	}

	public function dispose()
	{
		_tinkRequest = null;
	}

}

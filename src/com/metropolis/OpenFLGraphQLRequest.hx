package com.metropolis;

import com.metropolis.Request;
import haxe.io.Bytes;
import lime.net.HTTPRequest;
import lime.net.HTTPRequestHeader;
import lime.net.HTTPRequestMethod;
import openfl.net.URLLoader;
import openfl.utils.Object;
import tjson.TJSON;

/**
 * Metropolis Haxe SDK
 * @author Asim
 * 
 * USING OPENFL
 */
class OpenFLGraphQLRequest extends URLLoader implements IServerRequest
{

	public static inline var COMPLETE:String = 'complete';

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
		super();

		serverUrl = _serverUrl;
		
		token = _token;
 
	}
	
	
	/* INTERFACE com.metropolis.IServerRequest */
	
	public function createRequest(_request:Request):Void 
	{
		request = _request;
		
		var obj:Object = {};
		obj.query = request.query;
		obj.variables = request.variables;
		obj.operationName = request.operation;

		var body = TJSON.encode(obj);
		var requestHeaders:Array<HTTPRequestHeader> = [];

		if (token != null)
			requestHeaders.push(new HTTPRequestHeader("Authorization", token));

		var request:HTTPRequest<String> = new HTTPRequest<String>();
		request.method = HTTPRequestMethod.POST;
		request.headers = requestHeaders;
		request.data = Bytes.ofString(body);
		request.contentType = "application/json";

		request.load(serverUrl).onComplete(function(data)
		{
			handleSuccess(data);
		}).onError(function(err)
		{
			handleFailure(err);
		});
	}

	private function handleSuccess(resp:Dynamic):Void
	{
		//trace(resp);

		var response:Object = TJSON.parse(resp);

		if (response.data == null)
		{
			var error:String = "SERVER_INTERNAL_ERROR";
			if (response.errors != null || response.errors.length > 0)
			{
				error = response.errors[0].message;
			}

			this.dispatchEvent(new ServerResponse(COMPLETE, error));

			return;
		}

		this.dispatchEvent(new ServerResponse(COMPLETE, response.data));
	}

	private function handleFailure(err:Dynamic):Void
	{
		trace(err);

		this.dispatchEvent(new ServerResponse(COMPLETE, "Unable to call server"));
	}

}

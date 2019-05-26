package com.metropolis;

import openfl.errors.Error;
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
 */
class GraphQLRequest extends URLLoader
{

	public static inline var COMPLETE:String = 'complete';

	private var resource:Resource<Object, Dynamic>;

	private var _serverUrl:String = null;
	private var _request:Request = null;
	private var _token:String = null;

	public var serverUrl(get, set):String;
	
	function get_serverUrl():String {
		return _serverUrl;
	}
	
	function set_serverUrl(serverUrl:String):String {
		return _serverUrl = serverUrl;
	}

	public var request(get, set):Request;
	
	function get_request():Request {
		return _request;
	}
	
	function set_request(request:Request):Request {
		return _request = request;
	}

	public var token(get, set):String;
	
	function get_token():String {
		return _token;
	}
	
	function set_token(token:String):String {
		return _token = token;
	}

	public function new(serverUrl:String, request:Request, token:String = null)
	{
		super();

		_serverUrl = serverUrl;
		_request = request;
		_token = token;

		resource = new Resource();

		var obj:Object = {};
		obj.query = _request.query;
		obj.variables = _request.variables;
		obj.operationName = _request.operation;

		var body = TJSON.encode(obj);
		var requestHeaders:Array<HTTPRequestHeader> = [];

		if (_token != null)
			requestHeaders.push(new HTTPRequestHeader("Authorization", _token));

		var request:HTTPRequest<String> = new HTTPRequest<String>();
		request.method = HTTPRequestMethod.POST;
		request.headers = requestHeaders;
		request.data = Bytes.ofString(body);
		request.contentType = "application/json";

		request.load(_serverUrl).onComplete(function(data)
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

			resource.failure = error;

			this.dispatchEvent(new ServerResponse(COMPLETE, resource));

			return;
		}

		resource.success = response.data;

		this.dispatchEvent(new ServerResponse(COMPLETE, resource));
	}

	private function handleFailure(err:Dynamic):Void
	{
		trace(err);

		resource.failure = "Unable to call server";

		this.dispatchEvent(new ServerResponse(COMPLETE, resource));
	}
}

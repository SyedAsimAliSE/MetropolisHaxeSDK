package com.metropolis;

import com.metropolis.Request;
import haxe.io.Bytes;
import openfl.events.EventDispatcher;
import openfl.utils.Object;
import tink.http.Client;
import tink.http.Fetch.FetchOptions;
import tink.http.Header.HeaderField;
import tjson.TJSON;

/**
 * Metropolis Haxe SDK
 * @author Asim
 *
 * Using TINK LIB
 */
@async class TinkGraphQLRequest extends EventDispatcher implements IServerRequest
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

	@async public function createRequest(_request:Request):Void
	{

		request = _request;

		//Preparing gql query
		var obj:Object = {};
		obj.query = request.query;
		obj.variables = request.variables;
		obj.operationName = request.operation;

		var parsedBody = TJSON.encode(obj);
		var body = Bytes.ofString(parsedBody);

		//Preparing Headers
		var requestHeaders:Array<HeaderField> = [];
		requestHeaders.push(new HeaderField(CONTENT_TYPE, "application/json"));

		if (token != null)
			requestHeaders.push(new HeaderField("Authorization", token));

		var options:FetchOptions =
		{
			method: POST,
			headers: requestHeaders,
			body: body,
		};

		@await Client.fetch(serverUrl, options).all().handle(function(o) switch o
		{
			case Success(res):
				{
					var bytes = res.body.toString();
					trace(res.header.statusCode+" REP: " + bytes);

					handleSuccess(res);
				}

			case Failure(err):
				{
					handleFailure(err);
					trace(err);
				}
		});
	}

	private function handleSuccess(resp:Dynamic):Void
	{
		//trace(resp);

		var body = resp.body.toString();
		var code = resp.header.statusCode;

		var response:Object = TJSON.parse(body);

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

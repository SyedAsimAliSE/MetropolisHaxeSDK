package com.metropolis;

import com.metropolis.internals.Request;
import com.metropolis.internals.RequestBase;
import com.metropolis.internals.Resource;
import haxe.io.Bytes;
import openfl.utils.Object;
import tink.http.Client;
import tink.http.Fetch.FetchOptions;
import tink.http.Header.HeaderField;
import tjson.TJSON;

using com.metropolis.internals.EventHandler;

/**
 * Metropolis Haxe SDK
 * @author Asim
 *
 * Using TINK LIB
 */
class TinkRequest extends RequestBase
{

	public var onRequestComplete = new EventHandler<Resource<Object, String>->Void>();

	private var _resource:Resource<Object, String> = null; //will have the payload

	public function new(_serverUrl:String, _token:String = null)
	{
		super(_serverUrl, _token);

		_resource = new Resource();
	}

	/* INTERFACE com.metropolis.IServerRequest */

	public function createRequest(_request:Request):Void
	{
		request = _request;

		_resource.resName = request.operation;

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

		Client.fetch(serverUrl, options).all().handle(function(outcome) switch outcome
	{
		case Success(res): handleSuccess(res);

			case Failure(err): handleFailure(err);
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

			_resource.failure = error;

			this.onRequestComplete.dispatch(_resource);

			return;
		}

		_resource.success = response.data;
		this.onRequestComplete.dispatch(_resource);

	}

	private function handleFailure(err:Dynamic):Void
	{
		_resource.failure = "Unable to call server";
		this.onRequestComplete.dispatch(_resource);
	}

}

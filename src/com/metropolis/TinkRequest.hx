package com.metropolis;

import com.metropolis.internals.Request;
import com.metropolis.internals.RequestBase;
import com.metropolis.internals.Resource;
import haxe.io.Bytes;
import openfl.utils.Object;
import promhx.*;
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
class TinkRequest extends RequestBase
{

	private var _resource:Resource<Object, String> = null; //will have the payload

	public function new(_serverUrl:String, _token:String = null)
	{
		super(_serverUrl, _token);

		_resource = new Resource();
	}

	public function createRequest(_request:Request):Promise<Resource<Object, String>>
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
			requestHeaders.push(new HeaderField(AUTHORIZATION, token));

		var options:FetchOptions =
		{
			method: POST,
			headers: requestHeaders,
			body: body,
		};

		//trace("TOKEN "+token);
		//trace("FetchOptions "+options);

		var deferred = new Deferred();

		Client.fetch(serverUrl, options).all().handle(function(outcome) switch outcome
		{
			case Success(resp):
				{
					//var header:Object = TJSON.parse(haxe.Json.stringify(resp.header));
					//var code = resp.header.statusCode;

					//trace(header);
					//trace(header.reason);
					//trace(resp.body);
					//trace(code);

					var body = resp.body.toString();
					var response:Object = TJSON.parse(body);

					//trace("DATA: "+response.data);
					//trace("ERRORS: "+response.errors);

					if (response.data == null)
					{
						var error:String = "SERVER_INTERNAL_ERROR";
						if (response.errors != null || response.errors.length > 0)
						{
							error = response.errors[0].message;
						}

						_resource.failure = error;

						deferred.resolve(_resource);

						return;
					}

					_resource.success = response.data;

					//trace("TINKER "+_resource);

					deferred.resolve(_resource);
				}

			case Failure(err): {
					deferred.throwError(err);
				}
		});

		return new Promise(deferred);

	}//

}

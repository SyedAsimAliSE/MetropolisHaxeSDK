package com.metropolis;

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

	public function new(query:String, variables:Object, operationName:String, token:String = null)
	{
		super();

		resource = new Resource();

		var obj:Object = {};
		obj.query = query;
		obj.variables = variables;
		obj.operationName = operationName;

		var body = TJSON.encode(obj);
		var requestHeaders:Array<HTTPRequestHeader> = [];

		if (token != null)
			requestHeaders.push(new HTTPRequestHeader("Authorization", token));

		var request:HTTPRequest<String> = new HTTPRequest<String>();
		request.method = HTTPRequestMethod.POST;
		request.headers = requestHeaders;
		request.data = Bytes.ofString(body);
		request.contentType = "application/json";

		request.load(Constants.METROPOLIS_API_URL).onComplete(function(data)
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

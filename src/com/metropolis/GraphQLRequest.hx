package com.metropolis;

import haxe.io.Bytes;
import lime.net.HTTPRequestMethod;
import lime.net.HTTPRequest;
import lime.net.HTTPRequestHeader;
import tjson.TJSON;
import openfl.utils.Object;
import openfl.net.URLLoader;

/**
 * Metropolis Haxe SDK
 * @author Asim
 */
class GraphQLRequest extends URLLoader {
	public static inline var SUCCESS:String = 'success';
	public static inline var FAILURE:String = 'failure';

	public function new(query:String, variables:Object, operationName:String, token:String = null) {
		super();

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

		request.load(Constants.METROPOLIS_API_URL).onComplete(function(data) {
			handleSuccess(data);
		}).onError(function(err) {
			handleFailure(err);
		});
	}

	private function handleSuccess(resp:Dynamic):Void {
		//trace(resp);

		var response:Object = TJSON.parse(resp);

		if (response.data == null) {
			var error:String = "SERVER_INTERNAL_ERROR";
			if (response.errors != null || response.errors.length > 0) {
				error = response.errors[0].message;
			}

			this.dispatchEvent(new ServerResponse(FAILURE, error));

			return;
		}

		this.dispatchEvent(new ServerResponse(SUCCESS, response));
	}

	private function handleFailure(err:Dynamic):Void {
		trace(err);

		this.dispatchEvent(new ServerResponse(FAILURE, "Unable to call server"));
	}
}

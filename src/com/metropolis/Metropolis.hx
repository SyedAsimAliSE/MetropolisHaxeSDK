package com.metropolis;

import openfl.utils.Object;
import com.metropolis.Request;

/**
 * Metropolis Haxe SDK
 * @author Asim
 */
class Metropolis
{

	private var _accessToken:String = null;
	private var _delegate:IServerRequestDelegate = null;

	private var _request:GraphQLRequest = null;

	public var token(get, set):String;

	function get_token():String
	{
		return _accessToken;
	}

	function set_token(token:String):String
	{
		return _accessToken = token;
	}

	public function new(delegate:IServerRequestDelegate, accessToken:String = null)
	{
		_delegate = delegate;
		_accessToken = accessToken;
	}

	public function makeGraphQLRequest(request:Request):Void
	{

		_request = new GraphQLRequest(request.query, request.variables, request.operation, _accessToken);

		_request.addEventListener(GraphQLRequest.COMPLETE, handleGraphQLReqComplete);
	}

	private function handleGraphQLReqComplete(e:ServerResponse)
	{
		_delegate.serverRequestComplete(e);
	}

	public function dispose()
	{
		_request.removeEventListener(GraphQLRequest.COMPLETE, handleGraphQLReqComplete);

		_delegate = null;
		_request = null;
	}

}

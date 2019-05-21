package com.metropolis;

import openfl.utils.Object;

/**
 * Metropolis Haxe SDK
 * @author Asim
 */
class Metropolis {

	private var _accessToken:String = null;
	private var _delegate:IServerRequestDelegate = null;

    private var _request:GraphQLRequest = null; 
	
	public var token(get, set):String;
	
	function get_token():String {
		return _accessToken;
	}
	
	function set_token(token:String):String {
		return _accessToken = token;
	}

	public function new(delegate:IServerRequestDelegate, accessToken:String = null) {
		_delegate = delegate;
		_accessToken = accessToken;
	}

	public function makeGraphQLRequest(query:String, variables:Object, operationName:String):Void {
		_request = new GraphQLRequest(query, variables, operationName, _accessToken);

		_request.addEventListener(GraphQLRequest.SUCCESS, handleGraphQLReqSuccess);
		_request.addEventListener(GraphQLRequest.FAILURE, handleGraphQLReqFailure);
	}

	private function handleGraphQLReqSuccess(e:ServerResponse) {
		_delegate.serverRequestFinished(e);
	}

	private function handleGraphQLReqFailure(e:ServerResponse) {
		_delegate.serverRequestFailed(e);
	}

    public function dispose() {
        _request.removeEventListener(GraphQLRequest.SUCCESS, handleGraphQLReqSuccess);
		_request.removeEventListener(GraphQLRequest.FAILURE, handleGraphQLReqFailure);
        _delegate = null;
        _request = null;
    }

}

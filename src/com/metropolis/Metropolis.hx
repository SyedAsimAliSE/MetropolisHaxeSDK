package com.metropolis;

import openfl.errors.Error;
import com.metropolis.Request;

/**
 * Metropolis Haxe SDK
 * @author Asim
 */
class Metropolis
{
	private var _serverURL:String = null;

	private var _accessToken:String = null;
	private var _delegate:IServerRequestDelegate = null;

	private var _request:GraphQLRequest = null;
	private var _isRequestInProgress:Bool = false;

	public var token(get, set):String;

	function get_token():String
	{
		return _accessToken;
	}

	function set_token(token:String):String
	{
		return _accessToken = token;
	}

	public var serverURL(get, set):String;
    
    function get_serverURL():String {
        return _serverURL;
    }
    
    function set_serverURL(serverURL:String):String {
        return _serverURL = serverURL;
    }

	public function new(serverUrl:String = null)
	{
		_serverURL = serverUrl;
	}
 
	public function makeGraphQLRequest(delegate:IServerRequestDelegate, request:Request):Void
	{
		if(_serverURL == null) 
		{ 
			throw new Error("Unable to find Server URL, please set a URL."); 
		}

		_delegate = delegate;

		if(!_isRequestInProgress) 
		{

			_isRequestInProgress = true;
		
			_request = new GraphQLRequest(_serverURL, request, _accessToken);

			_request.addEventListener(GraphQLRequest.COMPLETE, handleGraphQLReqComplete);
		}
		
	}

	private function handleGraphQLReqComplete(e:ServerResponse)
	{
		_isRequestInProgress = false;

		_delegate.serverRequestComplete(e);
	}

	public function dispose()
	{
		_request.removeEventListener(GraphQLRequest.COMPLETE, handleGraphQLReqComplete);

		_delegate = null;
		_request = null;
	}

}

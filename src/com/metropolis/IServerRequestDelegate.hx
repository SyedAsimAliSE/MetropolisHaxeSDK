package com.metropolis;


/**
 * Metropolis Haxe SDK
 * @author Asim
 */
 
interface IServerRequestDelegate {

	function serverRequestFinished(response:ServerResponse):Void;
	
	function serverRequestFailed(response:ServerResponse):Void;

}

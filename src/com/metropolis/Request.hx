package com.metropolis;

import openfl.utils.Object;

/**
 * ...
 * @author Asim
 */
class Request {
	
	private var _query:String;
    private var _variables:Object;
    private var _operation:String;
	
	public function new(query:String = null, variables:Object = null, operation:String = null) 
	{
		_query = query;
		_variables = variables;
		_operation = operation;
	}

	public var query(get, set):String;
	
	function get_query():String {
		return _query;
	}
	
	function set_query(query:String):String {
		return _query = query;
	}

	public var variables(get, set):Object;
	
	function get_variables():Object {
		return _variables;
	}
	
	function set_variables(variables:Object):Object {
		return _variables = variables;
	}

	public var operation(get, set):String;
	
	function get_operation():String {
		return _operation;
	}
	
	function set_operation(operation:String):String {
		return _operation = operation;
	}


}
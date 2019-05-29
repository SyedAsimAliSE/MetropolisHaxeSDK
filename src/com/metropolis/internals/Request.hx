package com.metropolis.internals;

import openfl.utils.Object;

/**
 * ...
 * @author Asim
 */
class Request
{

	@:isVar public var query(get, set):String = null;
	function get_query():String { return query;	}
	function set_query(value:String):String { return query = value;	}

	@:isVar public var variables(get, set):Object = null;
	function get_variables():Object { return variables;	}
	function set_variables(value:Object):Object { return variables = value;	}

	@:isVar public var operation(get, set):String = null;
	function get_operation():String { return operation;	}
	function set_operation(value:String):String { return operation = value;	}

	public function new(_query:String = null, _variables:Object = null, _operation:String = null)
	{
		query = _query;
		variables = _variables;
		operation = _operation;
	}

}
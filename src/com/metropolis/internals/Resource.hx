package com.metropolis.internals;

/**
 * ...
 * @author Asim
 */

@:generic
class Resource<S, E>
{
	@:isVar public var resName(get, set):String = null;
	function get_resName():String { return resName;	}
	function set_resName(value:String):String { return resName = value;	}

	@:isVar public var success(get, set):S;
	function get_success():S { return success;	}
	function set_success(value:S):S { return success = value; }

	@:isVar public var failure(get, set):E;
	function get_failure():E { return failure; }
	function set_failure(value:E):E { return failure = value; }

	public function new(_resName:String = null, _success:S = null, _failure:E = null)
	{
		this.resName = _resName;
		this.success = _success;
		this.failure = _failure;
	}

}

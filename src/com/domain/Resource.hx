package com.domain;

/**
 * ...
 * @author Asim
 */

@:generic
class Resource<S, E>
{

	private var _success:S;
	private var _failure:E;

	public function new(success:S = null, failure:E = null)
	{
		this._success = success;
		this._failure = failure;
	}

	public var success(get, set):S;

	function get_success():S
	{
		return _success;
	}

	function set_success(success:S):S
	{
		return _success = success;
	}

	public var failure(get, set):E;

	function get_failure():E
	{
		return _failure;
	}

	function set_failure(failure:E):E
	{
		return _failure = failure;
	}

}

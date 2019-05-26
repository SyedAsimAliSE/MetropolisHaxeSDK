package com.metropolis;

import openfl.errors.Error;

/**
 * Metropolis Haxe SDK
 * @author Asim
 */

class Constants
{

	public static inline var METROPOLIS_API_URL:String = "http://localhost:8000/graphql";

	public function new()
	{
		throw new Error("Please use constants with Constants.CONSTANT");
	}
}

package com.valour.classes.data.remote;

import com.metropolis.internals.Request;
import com.metropolis.internals.Resource;
import com.valour.classes.service.RemoteHelper;
import openfl.utils.Object;
import promhx.Deferred;
import promhx.Promise;

/**
 * ...
 * @author Asim
 *
 * Every thing related to Remote API will be here
 */
class AppRemoteAPI
{
	private var _networkHelper:RemoteHelper = null;

	private var _request:Request = null;

	public function new(networkHelper:RemoteHelper)
	{
		_networkHelper = networkHelper;
	}

	//CALLS
	public function authenticateApp():Promise<Resource<Object, String>>
	{
		_request = new Request(
			"mutation authenticateApp($pkgName: String!) {\n  authenticateApp(pkgName: $pkgName) {\n    token\n  }\n}\n",
		{"pkgName":_networkHelper.PKG},
		"authenticateApp"
		);

		//return _networkHelper.server.createTinkerGQLReq(_request);

		var deferred = new Deferred();

		_networkHelper.server.createTinkerGQLReq(_request)
		.then(function (resource:Resource<Object, String>)
		{
			//trace(resource);
			if (resource.success != null)
			{
				_networkHelper.server.accessToken = resource.success.authenticateApp.token;

				resource.success = resource.success.authenticateApp.token;
			}

			deferred.resolve(resource);

		})
		.catchError(function(error)
		{
			//trace(error);
			deferred.throwError(error);
		});

		return new Promise(deferred);
	}

	public function getPortfolios():Promise<Resource<Object, String>>
	{
		_request = new Request(
			"query getPortfolios {\n  getPortfolios {\n    _id\n    type\n    name\n    desc\n    thumb\n    image\n  }\n}\n",
		{},
		"getPortfolios"
		);

		//return _networkHelper.server.createTinkerGQLReq(_request);

		var deferred = new Deferred();

		_networkHelper.server.createTinkerGQLReq(_request)
		.then(function (resource:Resource<Object, String>)
		{
			if (resource.success != null)
			{
				resource.success = resource.success.getPortfolios;
			}

			deferred.resolve(resource);

			//trace(deferred);
		})
		.catchError(function(error)
		{
			//trace(error);
			deferred.throwError(error);
		});

		return new Promise(deferred);
	}

}
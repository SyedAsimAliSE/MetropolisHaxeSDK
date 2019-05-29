package com.valour.classes.data.remote;

import com.metropolis.internals.Request;
import com.metropolis.internals.Resource;
import com.valour.classes.service.RemoteHelper;
import openfl.utils.Object;

using com.metropolis.internals.EventHandler;

/**
 * ...
 * @author Asim
 *
 * Every thing related to Remote API will be here
 */
class AppRemoteAPI
{
	public var onRemoteResponse = new EventHandler<Resource<Object, String>->Void>();

	private var _networkHelper:RemoteHelper = null;

	private var _request:Request = null;

	public function new(networkHelper:RemoteHelper)
	{
		_networkHelper = networkHelper;

		_networkHelper.server.onServerResponse += function(resource:Resource<Object, String>)
		{
			switch (resource.resName)
			{
				case "authenticateApp": handleAuthentication(resource);
				case "getPortfolios": handlePortfolios(resource);
				case "getPortfolioProjects": handlePortfolioProjects(resource);

				default:

			}

		};
	}

	//CALLS
	public function authenticateApp():Void
	{
		_request = new Request(
			"mutation authenticateApp($pkgName: String!) {\n  authenticateApp(pkgName: $pkgName) {\n    token\n  }\n}\n",
		{"pkgName":_networkHelper.PKG},
		"authenticateApp"
		);

		_networkHelper.server.createTinkerGQLReq(_request);
	}

	public function getPortfolios():Void
	{
		 _request = new Request(
			"query getPortfolios {\n  getPortfolios {\n    _id\n    type\n    name\n    desc\n    thumb\n    image\n  }\n}\n",
		{},
		"getPortfolios"
		);

		_networkHelper.server.createTinkerGQLReq(_request);
	}

	public function getPortfolioProjects(portfolioId:String):Void
	{
		_request = new Request(
			"query getPortfolioProjects($id: ID!) {\n  getPortfolioProjects(id: $id) {\n    _id\n    title\n    desc\n    thumbs\n    images\n    videos\n    duration\n    type\n    client\n    url\n    resUrl\n    techStack\n    tags\n    portfolio {\n      _id\n    }\n  }\n}\n",
		{"id":portfolioId},
		"getPortfolioProjects"
		);
		

		_networkHelper.server.createTinkerGQLReq(_request);
	}

	//HANDLERS
	private function handleAuthentication(resource:Resource<Object, String>):Void
	{
		if (resource.success != null)
		{
			_networkHelper.server.accessToken = resource.success.authenticateApp.token;

			resource.success = resource.success.authenticateApp.token;
		}

		//trace(resource);

		this.onRemoteResponse.dispatch(resource);
	}

	private function handlePortfolios(resource:Resource<Object, String>):Void
	{
		if (resource.success != null)
		{
			resource.success = resource.success.getPortfolios;
		}

		//trace(resource);

		this.onRemoteResponse.dispatch(resource);
	}

	private function handlePortfolioProjects(resource:Resource<Object, String>):Void
	{
		if (resource.success != null)
		{
			resource.success = resource.success.getPortfolioProjects;
		}

		//trace(resource);

		this.onRemoteResponse.dispatch(resource);
	}

}
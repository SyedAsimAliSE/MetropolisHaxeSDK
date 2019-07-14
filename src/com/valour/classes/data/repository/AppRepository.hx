package com.valour.classes.data.repository;

import com.domain.Portfolio;
import com.metropolis.internals.Resource;
import com.valour.classes.data.local.AppLocalAPI;
import com.valour.classes.data.remote.AppRemoteAPI;
import openfl.utils.Object;
import promhx.Deferred;
import promhx.Promise;


/**
 * ...
 * @author Asim
 *
 * This class is managing the data.
 */

class AppRepository
{
	
	private var _remoteSource:AppRemoteAPI = null;
	private var _localSource:AppLocalAPI = null;

	public function new(remoteSource:AppRemoteAPI, localSource:AppLocalAPI)
	{
		_remoteSource = remoteSource; 

		_localSource = localSource;
	}

	//CALLS

	public function authenticateApp():Promise<Resource<Object, String>>
	{
		return _remoteSource.authenticateApp();
	}

	public function getPortfolios():Promise<Resource<Array<Portfolio>, String>>
	{
		var deffered = new Deferred();
		var resp = _localSource.getPortfolios();
		//trace("IN REPO LOCAL "+resp);

		if (resp.failure != null )
		{
			_remoteSource.getPortfolios()
			.then(function (resource:Resource<Object, String>)
			{
				
				deffered.resolve(handlePortfolios(resource));
				
			})
			.catchError(function(error)
			{
				deffered.throwError(error);
			});
		}
		else 
		{
			deffered.resolve(resp);
		}

		return new Promise(deffered);
	}

	//HANDLERS

	private function handlePortfolios(resource:Resource<Object, String>):Resource<Array<Portfolio>, String>
	{
		var resp:Array<Portfolio> = cast resource.success;
		var result:Resource<Array<Portfolio>, String> = new Resource();
		var arrPortfolio:Array<Portfolio> = [];

		for (i in 0...resp.length)
		{
			var portfolio :Portfolio = new Portfolio();

			portfolio.serverId = Reflect.field(resp[i], "_id");
			portfolio.type = Reflect.field(resp[i], "type");
			portfolio.name = Reflect.field(resp[i], "name");
			portfolio.desc = Reflect.field(resp[i], "desc");
			portfolio.thumb = Reflect.field(resp[i], "thumb");
			portfolio.image = Reflect.field(resp[i], "image");

			arrPortfolio.push(portfolio);
		}

		//trace(arrPortfolio);

		//saving to local
		_localSource.savePortfolios(arrPortfolio);

		//returning from local
		//var localData:Array<Portfolio> = _localSource.getPortfolios().success;

		result.success = _localSource.getPortfolios().success;
		result.failure = resource.failure;
		result.resName = resource.resName;

		return result;
	}

}
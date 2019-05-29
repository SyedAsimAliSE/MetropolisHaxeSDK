package com.valour.classes.data.repository;

import com.domain.Portfolio;
import com.domain.Project;
import com.metropolis.internals.Resource;
import com.valour.classes.data.local.AppLocalAPI;
import com.valour.classes.data.remote.AppRemoteAPI;
import openfl.utils.Object;

using com.metropolis.internals.EventHandler;

/**
 * ...
 * @author Asim
 *
 * This class is managing the data.
 */

class AppRepository
{
	public var onAuthenticate = new EventHandler<Resource<Object, String>->Void>();
	public var onGettingtPortfolios = new EventHandler<Resource<Array<Portfolio>, String>->Void>();
	public var onGettingPortfolioProjects = new EventHandler<Resource<Array<Project>, String>->Void>();

	//...other endpoints

	private var _remoteSource:AppRemoteAPI = null;
	private var _localSource:AppLocalAPI = null;

	public function new(remoteSource:AppRemoteAPI, localSource:AppLocalAPI)
	{
		_remoteSource = remoteSource;
		_remoteSource.onRemoteResponse += function(resource:Resource<Object, String>)
		{
			switch (resource.resName)
			{
				case "authenticateApp": handleAuthentication(resource);
				case "getPortfolios": handlePortfolios(resource);
				case "getPortfolioProjects": handlePortfolioProjects(resource);

				default:

			}

		};

		_localSource = localSource;
	}

	//CALLS

	public function authenticateApp():Void
	{
		_remoteSource.authenticateApp();
	}

	public function getPortfolios():Resource<Array<Portfolio>, String>
	{
		var resp = _localSource.getPortfolios();
		//trace("IN REPO LOCAL "+resp);

		if (resp.failure != null )
		{
			_remoteSource.getPortfolios();
			return null;
		}

		return resp;
	}

	public function getPortfolioProjects(portfolioId:String):Resource<Array<Project>, String>
	{
		var resp = _localSource.getProjects();
		trace("IN REPO LOCAL "+resp);

		if (resp.failure != null )
		{
			_remoteSource.getPortfolioProjects(portfolioId);
			return null;
		}

		return resp;
	}

	//HANDLERS
	private function handleAuthentication(resource:Resource<Object, String>):Void
	{
		trace("AUTH "+resource);
		this.onAuthenticate.dispatch(resource);
	}

	private function handlePortfolios(resource:Resource<Object, String>):Void
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

		this.onGettingtPortfolios.dispatch(result);
	}

	private function handlePortfolioProjects(resource:Resource<Object, String>):Void
	{
		var resp:Array<Project> = cast resource.success;
		var result:Resource<Array<Project>, String> = new Resource();
		var arrProjects:Array<Project> = [];

		for (i in 0...resp.length)
		{
			var project:Project = new Project();

			//trace(Reflect.field(Reflect.field(resp[i], "portfolio"), "_id"));

			project.portfolioId = Reflect.field(Reflect.field(resp[i], "portfolio"), "_id");
			project.serverId 	= Reflect.field(resp[i], "_id");
			project.title 		= Reflect.field(resp[i], "title");
			project.desc 		= Reflect.field(resp[i], "desc");
			project.thumbs 		= Reflect.field(resp[i], "thumbs");
			project.images 		= Reflect.field(resp[i], "images");
			project.videos 		= Reflect.field(resp[i], "videos");
			project.duration 	= Reflect.field(resp[i], "duration");
			project.type 		= Reflect.field(resp[i], "type");
			project.client 		= Reflect.field(resp[i], "client");
			project.url 		= Reflect.field(resp[i], "url");
			project.resUrl 		= Reflect.field(resp[i], "resUrl");
			project.techStack 	= Reflect.field(resp[i], "techStack");
			project.tags 		= Reflect.field(resp[i], "tags");

			arrProjects.push(project);

		}

		//trace(arrProjects);

		_localSource.saveProjects(arrProjects);

		result.success = _localSource.getProjects().success;
		result.resName = resource.resName;
		result.failure = resource.failure;

		this.onGettingPortfolioProjects.dispatch(result);
	}

}
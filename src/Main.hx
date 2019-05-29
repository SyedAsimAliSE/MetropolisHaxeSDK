package;

import com.domain.Portfolio;
import com.domain.Project;
import com.metropolis.internals.Resource;
import com.valour.classes.comps.logger.Logger;
import com.valour.classes.service.ServiceProvider;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.utils.Object;

/**
 * Metropolis Haxe SDK
 * @author Asim
 */

class Main extends Sprite
{

	private var logger:Logger = null;

	public function new()
	{
		super();

		this.addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(evt:Event):Void
	{

		this.removeEventListener(Event.ADDED_TO_STAGE, init);

		logger = new Logger();
		addChild(logger);

		logger.log("Authenticating");
		logger.log("-------------");

		ServiceProvider.instance.appRepository.authenticateApp();
		ServiceProvider.instance.appRepository.onAuthenticate += function(resource:Resource<Object, String>)
		{
			//trace("DATA IN MANIN: " + resource);

			if (resource.success != null)
			{
				logger.log("AUTHENTICATED");
				logger.log("-------------");
				//logger.log(resource.success);

				getPortfolios();
				//getPortfolioProjects();
			}
			else
			{
				logger.log(resource.failure);
			}

		};
	}

	private function getPortfolios():Void
	{
		logger.log("GETTING PORTFOLIOS");
		logger.log("-------------");

		var data = ServiceProvider.instance.appRepository.getPortfolios();
		trace("IN MAIN LOCAL "+data);

		ServiceProvider.instance.appRepository.onGettingtPortfolios += function(resource:Resource<Array<Portfolio>, String>)
		{
			logger.log("GOT PORTFOLIOS");
			logger.log(resource.success[0].name);
			logger.log("-------------");
		};
	}

	private function getPortfolioProjects():Void
	{
		logger.log("GETTING PROJECTS");
		logger.log("-------------");

		var data = ServiceProvider.instance.appRepository.getPortfolioProjects("5ca87d9638a52e1c40b4c0c4");
		trace("IN MAIN LOCAL "+data);

		ServiceProvider.instance.appRepository.onGettingPortfolioProjects += function(resource:Resource<Array<Project>, String>)
		{
			logger.log("GOT PROJECTS");
			trace(resource);
			logger.log("-------------");			
		};

	}

}

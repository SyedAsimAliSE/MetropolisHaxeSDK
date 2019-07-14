package;

import com.domain.Portfolio;
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

		ServiceProvider.instance.appRepository.authenticateApp().then(function (resource:Resource<Object, String>)
		{
			if (resource.success != null)
			{
				logger.log("AUTHENTICATED");
				logger.log("-------------");
				logger.log(resource.success);

				getPortfolios();
			}
			else
			{
				logger.log(resource.failure);
			}
		}).catchError(function(error)
		{
			trace(error);
			logger.log("Unable to call server");
		});
	}

	private function getPortfolios():Void
	{
		logger.log("-------------");
		logger.log("GETTING PORTFOLIOS");
		logger.log("-------------");

		ServiceProvider.instance.appRepository.getPortfolios()
		.then(function(resource:Resource<Array<Portfolio>, String>)
		{
			//trace(resource);
			logger.log("GOT PORTFOLIOS");
			logger.log(resource.success[0].name);
			logger.log("-------------");
		}).catchError(function(error)
		{
			trace(error);
			logger.log("Unable to call server");
		});
	}
 

}

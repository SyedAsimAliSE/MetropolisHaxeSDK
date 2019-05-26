package;

import com.metropolis.IServerRequestDelegate;
import com.metropolis.Metropolis;
import com.metropolis.ServerResponse;
import com.valour.classes.comps.logger.Logger;
import com.valour.classes.data.AppConfigs;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * Metropolis Haxe SDK
 * @author Asim
 */

class Main extends Sprite implements IServerRequestDelegate
{

	private var _server:Metropolis = null;
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

		logger.log("Sending login call");

		_server = new Metropolis(this);

		authenticate();
	}

	private function authenticate():Void
	{
		//AUTHENTICATE
		_server.makeGraphQLRequest(
			"mutation authenticateApp($pkgName: String!) {\n  authenticateApp(pkgName: $pkgName) {\n    token\n  }\n}\n",
		{"pkgName":"del.del.del"},
		"authenticateApp"
		);
	}

	public function serverRequestComplete(response:ServerResponse):Void
	{

		trace('SUCCESS '+response.resource.success);
		trace('FAILED '+response.resource.failure);

		var _data = response.resource.success;
		var _err = response.resource.failure;

		if (_data != null)
		{

			if (_data.authenticateApp != null)
			{

				var token:String = _data.authenticateApp.token;
				var appConfigs = new AppConfigs(token);

				_server.token = token;

				logger.log(appConfigs.token);

			}

		}

		if (_err != null)
		{
			logger.log(_err);
		}

	}

}

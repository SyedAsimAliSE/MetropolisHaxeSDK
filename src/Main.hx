package;

import com.metropolis.ServerResponse;
import com.metropolis.IServerRequestDelegate;
import openfl.events.Event;
import openfl.display.Sprite;
import openfl.Lib;
import com.metropolis.Metropolis;
import com.valour.classes.comps.logger.Logger;


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

	private function init(evt:Event):Void {
		
		this.removeEventListener(Event.ADDED_TO_STAGE, init);

		logger = new Logger();
		addChild(logger);


		logger.log("Sending login call");
		
		_server = new Metropolis(this);
 
		authenticate();
	}
	
	private function authenticate():Void {
		//AUTHENTICATE
		_server.makeGraphQLRequest(
			"mutation authenticateApp($pkgName: String!) {\n  authenticateApp(pkgName: $pkgName) {\n    token\n  }\n}\n",
			{"pkgName":"del.del.del"},
			"authenticateApp"
		);
	}

	public function serverRequestFinished(response:ServerResponse):Void {
		
		trace('SUCCESS '+response.getData().data);

		logger.log("----------------");
		logger.log("GOT THE RESPONSE");
		logger.log("----------------");
		
	}

	public function serverRequestFailed(response:ServerResponse):Void {

		trace('FAILED '+response.getData());

		logger.log(response.getData());
	}

	
}

package com.valour.classes.data.repository;

import com.domain.Resource;
import com.domain.repository.IAppRepository;
import com.valour.classes.AppEvent;
import com.valour.classes.data.remote.AppRemoteAPI;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Asim
 */
class AppRepositoryImpl extends EventDispatcher implements IAppRepository
{
	public inline static var ON_AUTHENTICATE:String = "onAuthenticate";
	
	private var _remoteApi:AppRemoteAPI = null;

	public function new(remoteApi:AppRemoteAPI)
	{
		_remoteApi = remoteApi;
		
	}

	/* INTERFACE com.domain.repository.IAppRepository */

	public function authenticateApp():Resource
	{
		_remoteApi.authenticateApp();
		_remoteApi.addEventListener(AppRemoteAPI.ON_REMOTE_RESPONSE, function onResponse(evt:AppEvent)
		{
			trace(evt.data.RESP);
		}
	}

	public function dispose():Void
	{

	}

}
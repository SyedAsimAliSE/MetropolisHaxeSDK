package com.valour.classes.service;
import com.valour.classes.data.local.AppLocalAPI;
import com.valour.classes.data.remote.AppRemoteAPI;
import com.valour.classes.data.repository.AppRepository;

/**
 * Metropolis Haxe SDK
 * @author Asim
 *
 * Dependencies Grapher
 */

class ServiceProvider implements Singleton
{

	//static public var instance(get, null):ServiceProvider;
	//static function get_instance(): ServiceProvider return (instance == null) ? instance = new ServiceProvider() : instance;

	@:isVar public var remoteHelper(get, null):RemoteHelper = null;
	function get_remoteHelper():RemoteHelper { return remoteHelper; }

	@:isVar public var localHelper(get, null):LocalHelper = null;
	function get_localHelper():LocalHelper { return localHelper; }

	@:isVar public var appRepository(get, null):AppRepository;
	function get_appRepository():AppRepository { return appRepository; }

	private var remoteApi:AppRemoteAPI = null;
	private var localApi:AppLocalAPI = null;

	public function new()
	{

		remoteHelper = new RemoteHelper();
		remoteHelper.baseUrl = "http://localhost:8000/graphql";
		remoteHelper.PKG = "del.del.del";
		remoteHelper.setup();

		localHelper = new LocalHelper("siteDB.json");

		remoteApi = new AppRemoteAPI(remoteHelper);
		localApi = new AppLocalAPI(localHelper);

		appRepository = new AppRepository(remoteApi, localApi);

	}

}
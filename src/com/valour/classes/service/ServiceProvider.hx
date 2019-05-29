package com.valour.classes.service;
import com.domain.repository.IAppRepository;
import com.valour.classes.data.remote.AppRemoteAPI;
import com.valour.classes.data.repository.AppRepositoryImpl;

class ServiceProvider implements Singleton
{

	//static public var instance(get, null):ServiceProvider;
	//static function get_instance(): ServiceProvider return (instance == null) ? instance = new ServiceProvider() : instance;

	public var networkHelper(get, null):NetworkHelper = null;
	function get_networkHelper():NetworkHelper { return networkHelper; }

	private var remoteApi:AppRemoteAPI = null;

	public var appRepository(get, null):IAppRepository;
	function get_appRepository():IAppRepository { return appRepository; }

	public function new()
	{

		networkHelper = new NetworkHelper();

		networkHelper.baseUrl = "http://localhost:8000/graphql";
		networkHelper.PKG = "del.del.del";

		remoteApi = new AppRemoteAPI(networkHelper);

		appRepository = new AppRepositoryImpl(remoteApi);

	}

}
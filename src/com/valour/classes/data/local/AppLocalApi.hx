package com.valour.classes.data.local;

import com.domain.Portfolio;
import com.metropolis.internals.Resource;
import com.valour.classes.service.LocalHelper;
import openfl.utils.Object;

using com.metropolis.internals.EventHandler;

/**
 * ...
 * @author Asim
 */
class AppLocalAPI
{
	public var onLocalResponse = new EventHandler<Resource<Object, String> ->Void>();

	private var _localHelper:LocalHelper = null;

	public function new(localHelper:LocalHelper)
	{
		this._localHelper = localHelper;
	}

	public function savePortfolios(portfolios:Array<Portfolio>):Void
	{
		var data = _localHelper.db.idCol(Portfolio);

		for (i in 0...portfolios.length)
		{
			data.idInsert(portfolios[i]);
		}

		_localHelper.db.save();

		//trace("DB "+_localHelper.db.backup());
	}

	public function getPortfolios():Resource<Array<Portfolio>, String>
	{
		var resource:Resource<Array<Portfolio>, String> = new Resource();
		var data:Array<Portfolio> = _localHelper.db.idCol(Portfolio);

		resource.resName = "getPortfolios";

		if (data != null && data.length > 0)
		{
			resource.success = data;
		}
		else {
			resource.failure = "No Records Found";
		}

		//trace(resource);

		//trace("DB " + _localHelper.db.backup());

		return resource;
	}

}

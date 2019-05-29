package com.valour.classes.service;
import js.Browser;

/**
 * ...
 * @author Asim
 */
class LocalHelper
{

	@:isVar public var dbName(get, set):String;
	function get_dbName():String { return dbName; }
	function set_dbName(value:String):String { return dbName = value; }

	@:isVar public var db(get, null):HaxeLow = null;
	function get_db():HaxeLow { return db; }

	public function new(_dbName:String = null)
	{
		this.dbName = _dbName;

		db = new HaxeLow(this.dbName);
		//db = new HaxeLow(this.dbName, new HaxeLow.SysDisk());
		//db = new HaxeLow(this.dbName, new HaxeLow.LocalStorageDisk());
		
		deleteDatabase();
	}

	public function deleteDatabase():Void
	{
		Browser.getLocalStorage().removeItem(db.file);
	}

}
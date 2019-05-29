package com.domain;

/**
 * ...
 * @author Asim
 */
class Portfolio
{
	public var id:String = HaxeLow.uuid();
	@:isVar public var serverId(get, set):String = null;
	@:isVar public var type(get, set):String = null;
	@:isVar public var name(get, set):String = null;
	@:isVar public var desc(get, set):String = null;
	@:isVar public var thumb(get, set):String = null;
	@:isVar public var image(get, set):String = null;

	public function new(_serverId:String = null,
						_type:String = null,
						_name:String = null,
						_desc:String = null,
						_thumb:String = null,
						_image:String = null)
	{

		serverId = _serverId;
		type  = _type;
		name  = _name;
		desc  = _desc;
		thumb  = _thumb;
		image  = _image;
	}
	
	function get_serverId():String { return serverId; }	
	function set_serverId(value:String):String { return serverId = value; }
	
	function get_type():String { return type; }	
	function set_type(value:String):String { return type = value; }
	
	function get_name():String { return name; }	
	function set_name(value:String):String { return name = value; }
	
	function get_desc():String { return desc; }	
	function set_desc(value:String):String { return desc = value; }
	
	function get_thumb():String { return thumb; }	
	function set_thumb(value:String):String { return thumb = value;	}
	
	function get_image():String { return image;	}	
	function set_image(value:String):String { return image = value;	}

}

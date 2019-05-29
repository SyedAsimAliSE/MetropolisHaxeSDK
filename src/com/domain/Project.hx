package com.domain;

/**
 * ...
 * @author Asim
 */
class Project
{

	public var id:String = HaxeLow.uuid();
	@:isVar public var portfolioId(get, set):String = null;
	@:isVar public var serverId(get, set):String = null;
	@:isVar public var title(get, set):String = null;
	@:isVar public var desc(get, set):String = null;
	@:isVar public var thumbs(get, set):Array<String> = null;
	@:isVar public var images(get, set):Array<String> = null;
	@:isVar public var videos(get, set):Array<String> = null;
	@:isVar public var duration(get, set):String = null;
	@:isVar public var type(get, set):String = null;
	@:isVar public var client(get, set):String = null;
	@:isVar public var url(get, set):String = null;
	@:isVar public var resUrl(get, set):String = null;
	@:isVar public var techStack(get, set):Array<String> = null;
	@:isVar public var tags(get, set):Array<String> = null;

	public function new (
		_portfolioId:String = null,
		_serverId:String = null,
		_title:String = null,
		_desc:String = null,
		_thumbs:Array<String> = null,
		_images:Array<String> = null,
		_videos:Array<String> = null,
		_duration:String = null,
		_type:String = null,
		_client:String = null,
		_url:String = null,
		_resUrl:String = null,
		_techStack:Array<String> = null,
		_tags:Array<String> =  null)
	{

		portfolioId = _portfolioId;
		serverId = _serverId;
		title = _title;
		desc = _desc;
		thumbs = _thumbs;
		images = _images;
		videos = _videos;
		duration = _duration;
		type = _type;
		client = _client;
		url = _url;
		resUrl = _resUrl;
		techStack = _techStack;
		tags = _tags;

	}

	function get_serverId():String { return serverId; }
	function set_serverId(value:String):String { return serverId = value; }

	function get_title():String { return title;	}
	function set_title(value:String):String { return title = value;	}

	function get_desc():String { return desc; }
	function set_desc(value:String):String { return desc = value; }

	function get_thumbs():Array<String> { return thumbs; }
	function set_thumbs(value:Array<String>):Array<String> { return thumbs = value;	}

	function get_images():Array<String> { return images; }
	function set_images(value:Array<String>):Array<String> { return images = value;	}

	function get_videos():Array<String> { return videos; }
	function set_videos(value:Array<String>):Array<String> { return videos = value;	}

	function get_duration():String { return duration; }
	function set_duration(value:String):String { return duration = value; }

	function get_type():String { return type; }
	function set_type(value:String):String { return type = value; }

	function get_client():String { return client; }
	function set_client(value:String):String { return client = value; }

	function get_url():String { return url;	}
	function set_url(value:String):String { return url = value;	}

	function get_resUrl():String { return resUrl; }
	function set_resUrl(value:String):String { return resUrl = value; }

	function get_techStack():Array<String> { return techStack; }
	function set_techStack(value:Array<String>):Array<String> { return techStack = value; }

	function get_tags():Array<String> { return tags; }
	function set_tags(value:Array<String>):Array<String> { return tags = value;	}

	function get_portfolioId():String
	{
		return portfolioId;
	}

	function set_portfolioId(value:String):String
	{
		return portfolioId = value;
	}

}

package com.valour.classes.comps.logger;

import openfl.display.FPS;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * A Logger view to show traces in a small window overlay along with FPS
 *
 * @author Asim
 */

class Logger extends Sprite
{

	private var _logView:TextField;

	public function new()
	{

		super();

		createBG();

		createField();

		var fps:FPS = new FPS();
		addChild(fps);

	}

	private function createBG():Void
	{

		addChild(createShape(0,20, 220, 300, 0xFFFFFF, 0.2)); //Log BG

		addChild(createShape(0,10, 220, 20, 0xFFFFFF)); //FPS BG
	}

	private function createField():Void
	{
		//var font = Assets.getFont("fonts/GADUGI.TTF");
		var format:TextFormat = new TextFormat();
		//format.font = font.fontName;
		format.size = 12;
		format.align = TextFormatAlign.LEFT;

		_logView = new TextField();

		_logView.type = TextFieldType.DYNAMIC;
		_logView.defaultTextFormat = format;
		_logView.textColor = 0xFFFFFF;
		_logView.width = 220;
		_logView.height = 300;
		_logView.x = 10;
		_logView.y = 40;

		// _logView.embedFonts = embed;
		_logView.selectable = true;
		_logView.multiline = true;
		_logView.wordWrap = true;
		_logView.border = false;

		addChild(_logView);
	}

	private function createShape(_x:Int, _y:Int, _w:Float, _h:Float, _color:Int = 0x000000, _alpha:Float = 1):Shape
	{

		var shape:Shape = new Shape();
		shape.graphics.beginFill (_color, _alpha);
		shape.graphics.drawRect (_x, _y, _w, _h);
		shape.graphics.endFill();

		return shape;
	}

	public function log(str:String):Void
	{
		_logView.appendText(str + '\n');

		if (_logView.length >= 300)
		{
			_logView.scrollV += 10;
		}
	}

}

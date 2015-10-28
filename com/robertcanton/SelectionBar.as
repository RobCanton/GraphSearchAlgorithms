package com.robertcanton
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.robertcanton.Colours;
	import com.robertcanton.Graph;
	import flash.automation.MouseAutomationAction;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class  SelectionBar extends Sprite
	{
		public var HEIGHT:int;
		private var WIDTH:int;
		private var g:Graph;
		private var stageWidth:int;
		private var font = new CourierNew();
		private var highlight_square:Sprite;
		private var highlight_bar:Sprite;
		private var selector_start:Sprite;
		private var selector_end:Sprite;
		private var selector_wall:Sprite;
		private var selector_blank:Sprite;
		private var fade:Number = 0.8;
		private var button_format:TextFormat = new TextFormat();
		private var label_start:TextField;
		private var label_end:TextField;
		private var label_wall:TextField;
		private var label_erase:TextField;
		
		public function SelectionBar(_g:Graph, _size:int, _stageWidth:int)
		{
			trace("ControlPanel.as is running...");
			g = _g;
			HEIGHT = _size;
			stageWidth = _stageWidth;
			WIDTH = stageWidth / 4;
			
			createPanel();
		}
		
		public function createPanel() 
		{
			button_format.size = stageWidth / 22;
			button_format.align = TextFormatAlign.CENTER;
			button_format.font = font.fontName;
			button_format.bold = true;
			button_format.underline = false;
			
			this.graphics.moveTo(0, -1);
			this.graphics.lineStyle(1, 0x000000, 1);
			this.graphics.lineTo(stageWidth, -1);
			selector_start = drawBtn(Colours.START_NODE);;
			selector_start.addEventListener(MouseEvent.MOUSE_DOWN, select_start);
			
			selector_end = drawBtn(Colours.END_NODE);
			selector_end.addEventListener(MouseEvent.MOUSE_DOWN, select_end);
			
			selector_wall = drawBtn(Colours.WALL_NODE);
			selector_wall.addEventListener(MouseEvent.MOUSE_DOWN, select_wall);
			
			selector_blank = drawBtn(Colours.BLANK_NODE);
			selector_blank.addEventListener(MouseEvent.MOUSE_DOWN, select_blank);
			
			highlight_square = drawBtn(Colours.HIGHLIGHT);
			highlight_square.x = 0;
			highlight_square.y = 0;
			highlight_square.alpha = 0;
			highlight_square.addEventListener(MouseEvent.MOUSE_UP, fadeOut);
			
			highlight_bar = drawBtn(Colours.HIGHLIGHT);
			highlight_bar.scaleY = 0.125;
			highlight_bar.x = 0;
			highlight_bar.y = HEIGHT - highlight_bar.height;

			/*
			highlight_bar = new Sprite;
			highlight_bar.graphics.clear();
			highlight_bar.graphics.beginFill(0x000000,1);
			highlight_bar.graphics.drawRect(0, 0, width, width);
			highlight_bar.graphics.endFill();
			highlight_bar.x = 0;
			highlight_bar.y = 0;
			//selector.y = HEIGHT - HEIGHT / 5;
			*/
			
			selector_start.x = 0;
			selector_start.y = 0;
			selector_end.x = WIDTH;
			selector_end.y = 0;
			selector_wall.x = WIDTH * 2;
			selector_wall.y = 0;
			selector_blank.x = WIDTH * 3;
			selector_blank.y = 0;
			
			label_start = makeText("Start", button_format, Colours.HIGHLIGHT);
			label_start.x = (selector_start.width / 2) - (label_start.width / 2);
			label_start.y = (selector_start.height / 2) - (label_start.height / 2);
			label_start.alpha = 1;
			selector_start.addChild(label_start);	
			
			label_end = makeText("End", button_format, Colours.GREY);
			label_end.x = (selector_end.width / 2) - (label_end.width / 2);
			label_end.y = (selector_end.height / 2) - (label_end.height / 2);
			label_end.alpha = 0.75;
			selector_end.addChild(label_end); 
			
			label_wall = makeText("Wall", button_format, Colours.GREY);
			label_wall.x = (selector_wall.width / 2) - (label_wall.width / 2);
			label_wall.y = (selector_wall.height / 2) - (label_wall.height / 2);
			label_wall.alpha = 0.75;
			selector_wall.addChild(label_wall); 
			
			label_erase = makeText("Erase", button_format, Colours.GREY);
			label_erase.x = (selector_blank.width / 2) - (label_erase.width / 2);
			label_erase.y = (selector_blank.height / 2) - (label_erase.height / 2);
			label_erase.alpha = 0.75;
			selector_blank.addChild(label_erase); 
			
			this.addChild(selector_start);
			this.addChild(selector_end);
			this.addChild(selector_wall);
			this.addChild(selector_blank);
			this.addChild(highlight_bar);
			this.addChild(highlight_square);
		}
		
		public function drawBtn(col:uint):Sprite
		{
			var temp:Sprite = new Sprite;
			temp.graphics.clear();
			//temp.graphics.lineStyle(1, 0x000000, 1);
			temp.graphics.beginFill(col, 1);
			temp.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			temp.graphics.endFill();
			return temp;
		}
		
		public function select_start(e:MouseEvent)
		{
			trace("Switching Node Type to Start");
			g.nodeType = 0;
			highlight_square.x = 0;
			highlight_square.alpha = 0;
			label_start.textColor = Colours.HIGHLIGHT;
			label_start.alpha = 1;
			label_end.textColor = Colours.GREY;
			label_end.alpha = 0.75;
			label_wall.textColor = Colours.GREY;
			label_wall.alpha = 0.75;
			label_erase.textColor = Colours.GREY;
			label_erase.alpha = 0.75;
			TweenLite.to(highlight_square, 0.4, { alpha: 1, ease:Strong.easeOut} );
		}
		
		public function select_end(e:MouseEvent)
		{
			trace("Switching Node Type to End");
			g.nodeType = 1;
			highlight_square.x = width * 0.25;
			highlight_square.alpha = 0;
			label_start.textColor = Colours.GREY;
			label_start.alpha = 0.75;
			label_end.textColor = Colours.HIGHLIGHT;
			label_end.alpha = 1;
			label_wall.textColor = Colours.GREY;
			label_wall.alpha = 0.75;
			label_erase.textColor = Colours.GREY;
			label_erase.alpha = 0.75;
			TweenLite.to(highlight_square, 0.4, { alpha: 1, ease:Strong.easeOut} );
		}
		public function select_wall(e:MouseEvent)
		{
			trace("Switching Node Type to Wall");
			g.nodeType = 2;
			highlight_square.x = width * 0.5;
			highlight_square.alpha = 0;
			label_start.textColor = Colours.GREY;
			label_start.alpha = 0.75;
			label_end.textColor = Colours.GREY;
			label_end.alpha = 0.75;
			label_wall.textColor = Colours.HIGHLIGHT;
			label_wall.alpha = 1;
			label_erase.textColor = Colours.GREY;
			label_erase.alpha = 0.75;
			TweenLite.to(highlight_square, 0.4, { alpha: 1, ease:Strong.easeOut} );
		}
		public function select_blank(e:MouseEvent)
		{
			trace("Switching Node Type to Blank");
			g.nodeType = 3;
			highlight_square.x = width * 0.75;
			highlight_square.alpha = 0;
			label_start.textColor = Colours.GREY;
			label_start.alpha = 0.75;
			label_end.textColor = Colours.GREY;
			label_end.alpha = 0.75;
			label_wall.textColor = Colours.GREY;
			label_wall.alpha = 0.75;
			label_erase.textColor = Colours.HIGHLIGHT;
			label_erase.alpha = 1;
			TweenLite.to(highlight_square, 0.4, { alpha: 1, ease:Strong.easeOut} );
		}
		
		public function fadeOut(e:MouseEvent):void
		{
			highlight_square.alpha = 1;
			TweenLite.to(highlight_square, 0.4, { alpha: 0, ease:Strong.easeOut } );
			
			switch (g.nodeType)
			{
				case 0:
					highlight_bar.x = 0;
					break;
				case 1:
					highlight_bar.x = width * 0.25;
					break;
				case 2:
					highlight_bar.x = width * 0.5;
					break;
				case 3:
					highlight_bar.x = width * 0.75;
					break;
			}
		
		}
		
		public function killListeners():void
		{
			selector_start.removeEventListener(MouseEvent.MOUSE_DOWN, select_start);

			selector_end.removeEventListener(MouseEvent.MOUSE_DOWN, select_end);

			selector_wall.removeEventListener(MouseEvent.MOUSE_DOWN, select_wall);

			selector_blank.removeEventListener(MouseEvent.MOUSE_DOWN, select_blank);
		}
		public function reviveListeners():void
		{
			selector_start.addEventListener(MouseEvent.MOUSE_DOWN, select_start);

			selector_end.addEventListener(MouseEvent.MOUSE_DOWN, select_end);

			selector_wall.addEventListener(MouseEvent.MOUSE_DOWN, select_wall);

			selector_blank.addEventListener(MouseEvent.MOUSE_DOWN, select_blank);
		}
		
		private function makeText(str:String, f:TextFormat, c:uint):TextField
		{
			var temp:TextField = new TextField;
			temp.textColor = c;
			temp.defaultTextFormat = f;
			temp.text = str;
			temp.autoSize = TextFieldAutoSize.CENTER;
			temp.selectable = false;
			return temp;
		}
	}
	
	
}
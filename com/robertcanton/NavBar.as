package com.robertcanton
{
	import com.greensock.core.TweenCore;
	import com.greensock.TweenLite;
	import com.robertcanton.Colours;
	import com.robertcanton.Graph;
	import com.robertcanton.SelectionBar;
	import com.robertcanton.SettingsMenu;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class NavBar extends Sprite
	{
		public var size:int;
		private var g:Graph
		private var stageWidth:int;
		private var stageHeight:int;
		private var search_title:TextField;
		private var bg:Sprite;
		private var bgTween:Sprite;
		private var sb:SelectionBar;
		private var showSettings:Boolean;
		private var settings:SettingsMenu;
		private var borderSize:int;
		private var bar:Sprite;
		private var hint:TextField;
		private var settingsTween:TweenLite;
		private var hintTween:TweenLite;
		
		public function NavBar(_g:Graph, _size:int, _stageWidth:int, _stageHeight:int, _sb:SelectionBar)
		{
			trace("NavBar.as is running...");
			g = _g;
			size = _size;
			stageWidth = _stageWidth;
			stageHeight = _stageHeight;
			sb = _sb;
			createBar();
		
		}
		
		public function createBar()
		{
			bar = new Sprite;
			
			borderSize = size / 2;
			settings = new SettingsMenu(g, stageWidth - size, stageHeight - (size * 2 + sb.height), stageWidth);
			settings.x = - settings.WIDTH;
			settings.y = size + borderSize;
			settings.alpha = 1;
			this.addChild(settings);
			
			bg = new Sprite;
			bg.graphics.beginFill(0x000000, 1);
			bg.graphics.drawRect(0, 0, stageWidth, size);
			bg.graphics.endFill();
			bar.addChild(bg);
			
			bgTween = new Sprite;
			bgTween.graphics.beginFill(Colours.HIGHLIGHT, 1);
			bgTween.graphics.drawRect(0, 0, stageWidth, size);
			bgTween.graphics.endFill();
			bgTween.alpha = 0;
			bar.addChild(bgTween);
			
			var titleFont = new CourierNew();
			
			var titleFormat:TextFormat = new TextFormat();
			titleFormat.size = Math.round(25 * stageWidth / 480);
			titleFormat.align = TextFormatAlign.CENTER;
			titleFormat.font = titleFont.fontName;
			titleFormat.bold = true;
			
			search_title = new TextField();
			search_title.textColor = 0xFFFFFF;
			search_title.defaultTextFormat = titleFormat;
			//search_title.embedFonts = true;
			//search_title.antiAliasType = AntiAliasType.ADVANCED;
			search_title.border = false;
			search_title.height = size;
			search_title.width = stageWidth * 0.70;
			search_title.x = stageWidth * 0.15;
			search_title.selectable = false;
			bar.addChild(search_title);
			
			search_title.text = "Depth First Search";
			this.addChild(bar);
			bar.addEventListener(MouseEvent.MOUSE_DOWN, fadeIn);
			
			var headerFont:TextFormat = new TextFormat();
			headerFont.size = stageWidth / 20;
			headerFont.align = TextFormatAlign.CENTER;
			headerFont.font = titleFont.fontName;
			headerFont.bold = true;
			headerFont.underline = false;
			/*
			hint = new TextField;
			hint.text = "Hold Down for Settings";
			hint.border = false;
			hint.width = stageWidth;
			hint.textColor = Colours.GREY;
			hint.defaultTextFormat = headerFont;
			hint.x = stageWidth / 2 - hint.width / 2;
			hint.y = height;
			this.addChild(hint);
			*/
		}
		
		public function change_search():void
		{
			switch (g.searchType)
			{
				case 0: //Switch to Breadth First Search
					trace("Change to Breadth First Search");
					search_title.text = "Breadth First Search";
					g.searchType = 1;
					break;
				case 1: //Switch to Depth First Search
					trace("Change to Best First Search");
					search_title.text = "Best First Search";
					g.searchType = 2;
					break;
				case 2: //Switch to Depth First Search
					trace("Change to A* Search");
					search_title.text = "A* Search";
					g.searchType = 3;
					break;
				case 3: //Switch to Depth First Search
					trace("Change to Depth First Search");
					search_title.text = "Depth First Search";
					g.searchType = 0;
					break;
			}
			g.doSearch();
		}
		
		public function fadeIn(e:MouseEvent):void
		{
			TweenLite.to(bgTween, 0.1, {alpha: 1});
			bar.removeEventListener(MouseEvent.MOUSE_DOWN, fadeIn);
			bar.addEventListener(MouseEvent.MOUSE_OUT, fadeOut);
			bar.addEventListener(MouseEvent.MOUSE_UP, fadeOut);
			showSettings = true;
			settingsTween = TweenLite.delayedCall(0.7, displaySettings, null, false);
			hintTween = TweenLite.delayedCall(0.2, changeTitle, null, false);
		}
		
		public function fadeOut(e:MouseEvent):void
		{
			hintTween.kill();
			
			switch (g.searchType)
			{
				case 0: //Switch to Breadth First Search
					search_title.text = "Depth First Search";
					break;
				case 1: //Switch to Depth First Search
					search_title.text = "Breadth First Search";
					break;
				case 2: //Switch to Depth First Search
					search_title.text = "Best First Search";
					break;
				case 3: //Switch to Depth First Search
					search_title.text = "A* Search";
					break;
			}
			
			if (showSettings)
			{
				settingsTween.kill();
				change_search();
				showSettings = false;
			}
			else
			{
				settings.close.removeEventListener(MouseEvent.MOUSE_DOWN, fadeOut);
				settings.x = - settings.WIDTH;
			}
			bar.addEventListener(MouseEvent.MOUSE_DOWN, fadeIn);
			TweenLite.to(bgTween, 1, { alpha: 0 } );
			/*
			TweenLite.delayedCall(0.7, reviveListener, null, false);
			bar.removeEventListener(MouseEvent.MOUSE_OUT, fadeOut);
			bar.removeEventListener(MouseEvent.MOUSE_UP, fadeOut);
			*/
		}
		
		public function changeTitle ():void
		{
			search_title.text = "Hold for Settings";
		}
		public function displaySettings():void
		{
			if (showSettings)
			{
				settings.x = borderSize;
				settings.close.addEventListener(MouseEvent.MOUSE_DOWN, fadeOut);
				bar.removeEventListener(MouseEvent.MOUSE_OUT, fadeOut);
				bar.removeEventListener(MouseEvent.MOUSE_UP, fadeOut);
				showSettings = false;
			}
		}
		/*
		public function reviveListener():void
		{
			
		}
		*/
	}

}
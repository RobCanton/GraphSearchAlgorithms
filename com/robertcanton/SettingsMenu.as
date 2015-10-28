package com.robertcanton
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class SettingsMenu extends Sprite
	{
		public var HEIGHT:int;
		public var WIDTH:int;
		private var stageWidth:int;
		private var g:Graph;
		private var bg:Sprite;
		public var close:Sprite;
		private var font = new CourierNew();
		private var titleFont:TextFormat = new TextFormat();
		private var headerFont:TextFormat = new TextFormat();
		private var linkFont:TextFormat = new TextFormat();
		private var title:TextField;
		private var h_gridSize:TextField;
		private var b_gridSmall:TextField;
		private var b_gridMedium:TextField;
		private var b_gridLarge:TextField;
		private var h_nodeLabels:TextField;
		private var h_warning:TextField;
		private var b_numLabel:TextField;
		private var b_goalDistLabel:TextField;
		private var b_startDistLabel:TextField;
		private var b_fValueLabel:TextField;
		private var h_order:TextField;
		private var b_chngOrder:TextField;
		private var b_up:TextField;
		private var b_right:TextField;
		private var b_left:TextField;
		private var b_down:TextField;
		private var h_dist:TextField
		private var b_manhattan:TextField;
		private var b_euclidean:TextField;
		private var h_me:TextField;
		private var b_me:TextField;
		private var h_donate:TextField;
		private var b_bitcoin:TextField;
		private var b_litecoin:TextField;
		private var bitcoin_img:Sprite;
		private var litecoin_img:Sprite;
		private var f_coinfield:TextField;
		private var h_thankyou:TextField;
		private var separator:Sprite;
		private var order:Array = new Array(0);
		private var new_order:String = "";
		private var count:int = 1;
		
		public function SettingsMenu(_g:Graph, _width:int, _height:int, _stageWidth:int)
		{
			g = _g;
			WIDTH = _width;
			HEIGHT = _height;
			stageWidth = _stageWidth;
			createPanel();
		}
		
		public function createPanel():void
		{
			bg = new Sprite;
			bg.graphics.beginFill(Colours.SETTINGS_BACKGROUND, 0.75);
			bg.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			bg.graphics.endFill();
			this.addChild(bg);
			
			titleFont.size = WIDTH / 22;
			titleFont.align = TextFormatAlign.CENTER;
			titleFont.font = font.fontName;
			titleFont.bold = true;
			titleFont.underline = true;
			
			headerFont.size = WIDTH / 22;
			headerFont.align = TextFormatAlign.CENTER;
			headerFont.font = font.fontName;
			headerFont.bold = true;
			headerFont.underline = false;
			
			linkFont.size = WIDTH / 24;
			linkFont.align = TextFormatAlign.CENTER;
			linkFont.font = font.fontName;
			linkFont.bold = true;
			linkFont.underline = false;
			
			title = makeText("Settings", titleFont, Colours.HIGHLIGHT);
			title.x = WIDTH / 2 - title.width / 2;
			this.addChild(title);
			
			h_gridSize = makeText("Grid Size", headerFont, Colours.HIGHLIGHT);
			h_gridSize.x = WIDTH / 2 - h_gridSize.width / 2;
			this.addChild(h_gridSize);
			
			b_gridSmall = makeText("Small", headerFont, Colours.DULL);
			b_gridSmall.x = WIDTH * 0.20 - b_gridSmall.width / 2;
			b_gridSmall.border = true;
			b_gridSmall.borderColor = Colours.DULL;
			this.addChild(b_gridSmall);
			b_gridSmall.addEventListener(MouseEvent.MOUSE_DOWN, grid_Small);
			
			b_gridMedium = makeText("Medium", headerFont, Colours.HIGHLIGHT);
			b_gridMedium.x = WIDTH * 0.50 - b_gridMedium.width / 2;
			b_gridMedium.border = true;
			b_gridMedium.borderColor = Colours.HIGHLIGHT;
			this.addChild(b_gridMedium);
			b_gridMedium.addEventListener(MouseEvent.MOUSE_DOWN, grid_Medium);
			
			b_gridLarge = makeText("Large", headerFont, Colours.DULL);
			b_gridLarge.x = WIDTH * 0.80 - b_gridLarge.width / 2;
			b_gridLarge.border = true;
			b_gridLarge.borderColor = Colours.DULL;
			this.addChild(b_gridLarge);
			b_gridLarge.addEventListener(MouseEvent.MOUSE_DOWN, grid_Large);
			
			h_nodeLabels = makeText("Labels", headerFont, Colours.HIGHLIGHT);
			h_nodeLabels.x = WIDTH / 3 - h_nodeLabels.width / 2;
			this.addChild(h_nodeLabels);
			
			h_warning = makeText("(Slows performance)", linkFont, Colours.GREY);
			h_warning.x = h_nodeLabels.x + h_nodeLabels.width * 1.10;
			this.addChild(h_warning);
			
			b_numLabel = makeText("Number", headerFont, Colours.HIGHLIGHT);
			b_numLabel.x = WIDTH * 0.20 - b_numLabel.width / 2;
			b_numLabel.border = true;
			b_numLabel.borderColor = Colours.HIGHLIGHT;
			this.addChild(b_numLabel);
			b_numLabel.addEventListener(MouseEvent.MOUSE_DOWN, toggle_numLabel);
			
			b_goalDistLabel = makeText("Goal\nDist.", headerFont, Colours.DULL);
			b_goalDistLabel.x = WIDTH * 0.40 - b_goalDistLabel.width / 2;
			b_goalDistLabel.border = true;
			b_goalDistLabel.borderColor = Colours.DULL;
			this.addChild(b_goalDistLabel);
			b_goalDistLabel.addEventListener(MouseEvent.MOUSE_DOWN, toggle_goalDistLabel);
			
			b_startDistLabel = makeText("Start\nDist.", headerFont, Colours.DULL);
			b_startDistLabel.x = WIDTH * 0.60 - b_startDistLabel.width / 2;
			b_startDistLabel.border = true;
			b_startDistLabel.borderColor = Colours.DULL;
			this.addChild(b_startDistLabel);
			b_startDistLabel.addEventListener(MouseEvent.MOUSE_DOWN, toggle_startDistLabel);
			
			b_fValueLabel = makeText("F\nValue", headerFont, Colours.DULL);
			b_fValueLabel.x = WIDTH * 0.80 - b_fValueLabel.width / 2;
			b_fValueLabel.border = true;
			b_fValueLabel.borderColor = Colours.DULL;
			this.addChild(b_fValueLabel);
			b_fValueLabel.addEventListener(MouseEvent.MOUSE_DOWN, toggle_fValueLabel);
			
			h_order = makeText("Default Search Order", headerFont, Colours.HIGHLIGHT);
			h_order.x = WIDTH / 2 - h_order.width / 2;
			this.addChild(h_order);
			
			b_up = makeText("1\nUp", headerFont, Colours.HIGHLIGHT);
			b_up.x = WIDTH * 0.20 - b_up.width / 2;
			//b_t.border = true;
			b_up.borderColor = Colours.HIGHLIGHT;
			this.addChild(b_up);
			
			b_down = makeText("2\nDown", headerFont, Colours.HIGHLIGHT);
			b_down.x = WIDTH * 0.40 - b_down.width / 2;
			//b_b.border = true;
			b_down.borderColor = Colours.HIGHLIGHT;
			this.addChild(b_down);
			
			b_left = makeText("3\nLeft", headerFont, Colours.HIGHLIGHT);
			b_left.x = WIDTH * 0.60 - b_left.width / 2;
			//b_l.border = true;
			b_left.borderColor = Colours.HIGHLIGHT;
			this.addChild(b_left);
			
			b_right = makeText("4\nRight", headerFont, Colours.HIGHLIGHT);
			b_right.x = WIDTH * 0.80 - b_right.width / 2;
			//b_r.border = true;
			b_right.borderColor = Colours.HIGHLIGHT;
			this.addChild(b_right);
			order.push('t');
			order.push('b');
			order.push('l');
			order.push('r');
			new_order = "tblr";
			trace(order);
			
			b_chngOrder = makeText("Change Order", headerFont, Colours.DULL);
			b_chngOrder.x = WIDTH * 0.50 - b_chngOrder.width / 2;
			b_chngOrder.border = true;
			b_chngOrder.borderColor = Colours.DULL;
			this.addChild(b_chngOrder);
			b_chngOrder.addEventListener(MouseEvent.MOUSE_DOWN, reset_order);
			
			h_dist = makeText("Distance Calculation", headerFont, Colours.HIGHLIGHT);
			h_dist.x = WIDTH / 2 - h_dist.width / 2;
			this.addChild(h_dist);
			
			b_euclidean = makeText("Euclidean", headerFont, Colours.HIGHLIGHT);
			b_euclidean.x = WIDTH * 0.33 - b_euclidean.width / 2;
			b_euclidean.border = true;
			b_euclidean.borderColor = Colours.HIGHLIGHT;
			this.addChild(b_euclidean);
			b_euclidean.addEventListener(MouseEvent.MOUSE_DOWN, set_euclidean);
			
			b_manhattan = makeText("Manhattan", headerFont, Colours.DULL);
			b_manhattan.x = WIDTH * 0.66 - b_manhattan.width / 2;
			b_manhattan.border = true;
			b_manhattan.borderColor = Colours.DULL;
			this.addChild(b_manhattan);
			b_manhattan.addEventListener(MouseEvent.MOUSE_DOWN, set_manhattan);
			
			//----------------------------------------------------------------//
			separator = new Sprite;
			separator.graphics.moveTo(0, HEIGHT * 0.67);
			separator.graphics.lineStyle(1, Colours.HIGHLIGHT, 1);
			separator.graphics.lineTo(WIDTH, HEIGHT * 0.67);
			this.addChild(separator);
			
			h_donate = makeText("Donate", headerFont, Colours.HIGHLIGHT);
			h_donate.x = WIDTH / 2 - h_donate.width / 2;
			this.addChild(h_donate);
			
			b_bitcoin = makeText("Bitcoins", headerFont, Colours.DULL);
			b_bitcoin.x = WIDTH * 0.33 - b_bitcoin.width / 2;
			b_bitcoin.border = true;
			b_bitcoin.borderColor = Colours.DULL;
			this.addChild(b_bitcoin);
			b_bitcoin.addEventListener(MouseEvent.MOUSE_DOWN, donate_bitCoins);
			
			b_litecoin = makeText("Litecoins", headerFont, Colours.DULL);
			b_litecoin.x = WIDTH * 0.66 - b_litecoin.width / 2;
			b_litecoin.border = true;
			b_litecoin.borderColor = Colours.DULL;
			this.addChild(b_litecoin);
			b_litecoin.addEventListener(MouseEvent.MOUSE_DOWN, donate_liteCoins);
			
			
			h_me = makeText("Made by Robert Canton", headerFont, Colours.HIGHLIGHT);
			h_me.x = WIDTH / 2 - h_me.width / 2;
			this.addChild(h_me);
			
			b_me = makeText("Visit My Website", headerFont, Colours.DULL);
			b_me.x = WIDTH / 2 - b_me.width / 2;
			b_me.border = true;
			b_me.borderColor = Colours.DULL;
			this.addChild(b_me);
			b_me.addEventListener(MouseEvent.MOUSE_DOWN, open_website);
			b_me.addEventListener(MouseEvent.MOUSE_UP, reset_me);
			
			//bitcoin image
			bitcoin_img = new qr_bitcoin;
			this.addChild(bitcoin_img);
			bitcoin_img.visible = false;
			bitcoin_img.scaleX = bitcoin_img.scaleY = stageWidth / 480;
			trace(bitcoin_img.scaleX);
			bitcoin_img.x = WIDTH / 2 - bitcoin_img.width / 2;
			bitcoin_img.y = HEIGHT * 0.10;
			
			//litecoin image
			litecoin_img = new qr_litecoin;
			this.addChild(litecoin_img);
			litecoin_img.visible = false;
			litecoin_img.scaleX = litecoin_img.scaleY = stageWidth / 480;
			litecoin_img.height = litecoin_img.width;
			litecoin_img.x = WIDTH / 2 - litecoin_img.width / 2;
			litecoin_img.y = HEIGHT * 0.10;
			
			f_coinfield = makeText("", linkFont, Colours.HIGHLIGHT);
			f_coinfield.x = WIDTH / 2 - f_coinfield.width / 2;
			f_coinfield.y = bitcoin_img.y + bitcoin_img.height + HEIGHT * 0.03;
			f_coinfield.selectable = true;
			f_coinfield.border = true;
			f_coinfield.borderColor = Colours.HIGHLIGHT;
			this.addChild(f_coinfield);
			f_coinfield.visible = false;
			
			h_thankyou = makeText("Thank you!", headerFont, Colours.HIGHLIGHT);
			h_thankyou.x = WIDTH / 2 - h_thankyou.width / 2;
			h_thankyou.y = f_coinfield.y + HEIGHT * 0.05;
			this.addChild(h_thankyou);
			h_thankyou.visible = false;
			
			title.y = HEIGHT * 0.02;
			h_gridSize.y = HEIGHT * 0.08;
			b_gridSmall.y = HEIGHT * 0.13;
			b_gridMedium.y = HEIGHT * 0.13;
			b_gridLarge.y = HEIGHT * 0.13;
			h_nodeLabels.y = HEIGHT * 0.20;
			h_warning.y = HEIGHT * 0.20;
			b_numLabel.y = HEIGHT * 0.25;
			b_goalDistLabel.y = HEIGHT * 0.25;
			b_startDistLabel.y = HEIGHT * 0.25;
			b_fValueLabel.y = HEIGHT * 0.25;
			h_order.y = HEIGHT * 0.35;
			b_up.y = HEIGHT * 0.40;
			b_down.y = HEIGHT * 0.40;
			b_left.y = HEIGHT * 0.40;
			b_right.y = HEIGHT * 0.40;
			b_chngOrder.y = HEIGHT * 0.49;
			h_dist.y = HEIGHT * 0.55;
			b_euclidean.y = HEIGHT * 0.60;
			b_manhattan.y = HEIGHT * 0.60;
			//------------------------------//
			h_donate.y = HEIGHT * 0.68;
			b_bitcoin.y = HEIGHT * 0.73;
			b_litecoin.y = HEIGHT * 0.73;
			h_me.y = HEIGHT * 0.79;
			b_me.y = HEIGHT * 0.85;
			
			
			var closeSize:int = WIDTH / 12;
			close = new Sprite;
			close.graphics.beginFill(0x000000, 0);
			close.graphics.drawRect(0, 0, closeSize, closeSize);
			close.graphics.endFill();
			close.graphics.lineStyle(3, Colours.HIGHLIGHT, 1);
			close.graphics.moveTo(0, 0);
			close.graphics.lineTo(closeSize, closeSize);
			close.graphics.moveTo(0, closeSize);
			close.graphics.lineTo(closeSize, 0);
			close.x = WIDTH / 2 - closeSize / 2;
			close.y = HEIGHT * 0.92;
			
			this.addChild(close);
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
		
		private function grid_Small(e:MouseEvent)
		{
			trace("Switching Grid Size to Small");
			b_gridSmall.borderColor = Colours.HIGHLIGHT;
			b_gridSmall.textColor = Colours.HIGHLIGHT
			b_gridMedium.borderColor = Colours.DULL;
			b_gridMedium.textColor = Colours.DULL
			b_gridLarge.borderColor = Colours.DULL;
			b_gridLarge.textColor = Colours.DULL
			var size:int = stage.stageWidth / 8;
			var rows:int = (stage.stageHeight * 0.85) / size;
			var cols:int = stage.stageWidth / size;
			g.resetGraph(rows, cols, size);
		}
		
		private function grid_Medium(e:MouseEvent)
		{
			trace("Switching Grid Size to Medium");
			b_gridSmall.borderColor = Colours.DULL;
			b_gridSmall.textColor = Colours.DULL
			b_gridMedium.borderColor = Colours.HIGHLIGHT;
			b_gridMedium.textColor = Colours.HIGHLIGHT
			b_gridLarge.borderColor = Colours.DULL;
			b_gridLarge.textColor = Colours.DULL
			var size:int = stage.stageWidth / 12;
			var rows:int = (stage.stageHeight * 0.85) / size;
			var cols:int = stage.stageWidth / size;
			g.resetGraph(rows, cols, size);
		}
		
		private function grid_Large(e:MouseEvent)
		{
			trace("Switching Grid Size to Large");
			b_gridSmall.borderColor = Colours.DULL;
			b_gridSmall.textColor = Colours.DULL
			b_gridMedium.borderColor = Colours.DULL;
			b_gridMedium.textColor = Colours.DULL
			b_gridLarge.borderColor = Colours.HIGHLIGHT;
			b_gridLarge.textColor = Colours.HIGHLIGHT
			var size:int = stage.stageWidth / 16;
			var rows:int = (stage.stageHeight * 0.85) / size;
			var cols:int = stage.stageWidth / size;
			g.resetGraph(rows, cols, size);
		}
		
		private function toggle_numLabel(e:MouseEvent)
		{
			trace("Toggling numLabel");
			if (g.numLabel_flag)
			{
				g.numLabel_flag = false;
				b_numLabel.textColor = Colours.DULL;
				b_numLabel.borderColor = Colours.DULL;
				g.modify_labels(0,false);
			}
			else
			{
				g.numLabel_flag = true;
				b_numLabel.textColor = Colours.HIGHLIGHT;
				b_numLabel.borderColor = Colours.HIGHLIGHT;
				g.modify_labels(0,true);
			}
		}
		
		private function toggle_goalDistLabel(e:MouseEvent)
		{
			trace("Toggling goalDistLabel");
			if (g.goalDistLabel_flag)
			{
				g.goalDistLabel_flag = false;
				b_goalDistLabel.textColor = Colours.DULL;
				b_goalDistLabel.borderColor = Colours.DULL;
				g.modify_labels(1,false);
			}
			else
			{
				g.goalDistLabel_flag = true;
				b_goalDistLabel.textColor = Colours.HIGHLIGHT;
				b_goalDistLabel.borderColor = Colours.HIGHLIGHT;
				g.modify_labels(1,true);
			}
		}
		
		private function toggle_startDistLabel(e:MouseEvent)
		{
			trace("Toggling startDistLabel");
			if (g.startLabel_flag)
			{
				g.startLabel_flag = false;
				b_startDistLabel.textColor = Colours.DULL;
				b_startDistLabel.borderColor = Colours.DULL;
				g.modify_labels(2,false);
			}
			else
			{
				g.startLabel_flag = true;
				b_startDistLabel.textColor = Colours.HIGHLIGHT;
				b_startDistLabel.borderColor = Colours.HIGHLIGHT;
				g.modify_labels(2,true);
			}
		}
		
		private function toggle_fValueLabel(e:MouseEvent)
		{
			trace("Toggling fValueLabel");
			if (g.fValueLabel_flag)
			{
				g.fValueLabel_flag = false;
				b_fValueLabel.textColor = Colours.DULL;
				b_fValueLabel.borderColor = Colours.DULL;
				g.modify_labels(3,false);
			}
			else
			{
				g.fValueLabel_flag = true;
				b_fValueLabel.textColor = Colours.HIGHLIGHT;
				b_fValueLabel.borderColor = Colours.HIGHLIGHT;
				g.modify_labels(3,true);
			}
		}
		
		private function set_manhattan(e:MouseEvent):void
		{
			trace("Distance Calculation: Manhattan");
			//hide_litecoin(e);
			b_manhattan.textColor = Colours.HIGHLIGHT;
			b_manhattan.borderColor = Colours.HIGHLIGHT;
			b_euclidean.textColor = Colours.DULL;
			b_euclidean.borderColor = Colours.DULL;
			g.dist_type = 1;
		}
		
		private function set_euclidean(e:MouseEvent):void
		{
			trace("Distance Calculation: Euclidean");
			//hide_litecoin(e);
			b_manhattan.textColor = Colours.DULL;
			b_manhattan.borderColor = Colours.DULL;
			b_euclidean.textColor = Colours.HIGHLIGHT;
			b_euclidean.borderColor = Colours.HIGHLIGHT;
			g.dist_type = 0;
		}
		
		private function open_website(e:MouseEvent)
		{
			trace("Opening website...");
			var url = "http://www.rcanton.com";
			var urlReq = new URLRequest(url);
			navigateToURL(urlReq);
			
			b_me.textColor = Colours.HIGHLIGHT;
			b_me.borderColor = Colours.HIGHLIGHT;
		}
		
		private function reset_me(e:MouseEvent)
		{
			b_me.textColor = Colours.DULL;
			b_me.borderColor = Colours.DULL;
		
		}
		
		private function donate_bitCoins(e:MouseEvent):void
		{
			trace("Donate Bitcoins");
			hide_litecoin(e);
			b_bitcoin.textColor = Colours.HIGHLIGHT;
			b_bitcoin.borderColor = Colours.HIGHLIGHT;
			b_bitcoin.removeEventListener(MouseEvent.MOUSE_DOWN, donate_bitCoins);
			b_bitcoin.addEventListener(MouseEvent.MOUSE_DOWN, hide_bitcoin);
			hide_other_settings();
			f_coinfield.text = "18xBfk5WG1vsHukLVx8rhEpnocPMUzMzLT";
			bitcoin_img.visible = true;
			f_coinfield.visible = true;
			h_thankyou.visible = true;
		}
		
		private function hide_bitcoin(e:MouseEvent):void
		{
			b_bitcoin.textColor = Colours.DULL;
			b_bitcoin.borderColor = Colours.DULL;
			b_bitcoin.removeEventListener(MouseEvent.MOUSE_DOWN, hide_bitcoin);
			b_bitcoin.addEventListener(MouseEvent.MOUSE_DOWN, donate_bitCoins);
			
			show_all_settings();
			
			bitcoin_img.visible = false;
			f_coinfield.visible = false;
			h_thankyou.visible = false;
		
		}
		
		private function donate_liteCoins(e:MouseEvent):void
		{
			trace("Donate Litecoins");
			hide_bitcoin(e);
			b_litecoin.textColor = Colours.HIGHLIGHT;
			b_litecoin.borderColor = Colours.HIGHLIGHT;
			b_litecoin.removeEventListener(MouseEvent.MOUSE_DOWN, donate_liteCoins);
			b_litecoin.addEventListener(MouseEvent.MOUSE_DOWN, hide_litecoin);
			
			hide_other_settings();
			
			f_coinfield.text = "LTB8vxPLLgAvYiSVg689yFtZ1pkdbt6mMz";
			litecoin_img.visible = true;
			f_coinfield.visible = true;
			h_thankyou.visible = true;
		}
		
		private function hide_litecoin(e:MouseEvent):void
		{
			b_litecoin.textColor = Colours.DULL;
			b_litecoin.borderColor = Colours.DULL;
			
			b_litecoin.removeEventListener(MouseEvent.MOUSE_DOWN, hide_litecoin);
			b_litecoin.addEventListener(MouseEvent.MOUSE_DOWN, donate_liteCoins);
			
			show_all_settings();
			
			litecoin_img.visible = false;
			f_coinfield.visible = false;
			h_thankyou.visible = false;
		
		}
		
		private function hide_other_settings():void
		{
			b_gridLarge.visible = false;
			b_gridMedium.visible = false;
			b_gridSmall.visible = false;
			//b_me.alpha = 0;
			b_numLabel.visible = false;
			h_gridSize.visible = false;
			//h_me.alpha = 0;
			h_nodeLabels.visible = false;
			h_order.visible = false;
			b_up.visible = false;
			b_down.visible = false;
			b_left.visible = false;
			b_right.visible = false;
			b_chngOrder.visible = false;
			h_dist.visible = false;
			b_euclidean.visible = false;
			b_manhattan.visible = false;
			b_goalDistLabel.visible = false;
			b_startDistLabel.visible = false;
			b_fValueLabel.visible = false;
			h_warning.visible = false;
		}
		
		private function show_all_settings():void
		{
			b_gridLarge.visible = true;
			b_gridMedium.visible = true;
			b_gridSmall.visible = true;
			//b_me.alpha = 0;
			b_numLabel.visible = true;
			h_gridSize.visible = true;
			//h_me.alpha = 0;
			h_nodeLabels.visible = true;
			h_order.visible = true;
			b_up.visible = true;
			b_down.visible = true;
			b_left.visible = true;
			b_right.visible = true;
			b_chngOrder.visible = true;
			h_dist.visible = true;
			b_euclidean.visible = true;
			b_manhattan.visible = true;
			b_goalDistLabel.visible = true;
			b_startDistLabel.visible = true;
			b_fValueLabel.visible = true;
			h_warning.visible = true;
		}
		
		private function reset_order(e:MouseEvent):void
		{
			trace("Resetting Order");
			new_order = "";
			b_chngOrder.textColor = Colours.HIGHLIGHT;
			b_chngOrder.borderColor = Colours.HIGHLIGHT;
			b_chngOrder.removeEventListener(MouseEvent.MOUSE_DOWN, reset_order);
			//b_chngOrder.addEventListener(MouseEvent.MOUSE_DOWN, hide_bitcoin);
			b_chngOrder.border = false;
			
			b_up.textColor = Colours.DULL;
			b_right.textColor = Colours.DULL;
			b_down.textColor = Colours.DULL;
			b_left.textColor = Colours.DULL;
			b_up.border = true;
			b_right.border = true;
			b_down.border = true;
			b_left.border = true;
			b_up.borderColor = Colours.DULL;
			b_right.borderColor = Colours.DULL;
			b_down.borderColor = Colours.DULL;
			b_left.borderColor = Colours.DULL;
			b_up.addEventListener(MouseEvent.MOUSE_DOWN, set_up);
			b_down.addEventListener(MouseEvent.MOUSE_DOWN, set_down);
			b_left.addEventListener(MouseEvent.MOUSE_DOWN, set_left);
			b_right.addEventListener(MouseEvent.MOUSE_DOWN, set_right);
			b_up.text = "-\nUp";
			b_down.text = "-\nDown";
			b_left.text = "-\nLeft";
			b_right.text = "-\nRight";
			count = 1;
		}
		
		private function set_order():void
		{
			trace("yp " + new_order);
			g.default_order = "";
			g.default_order = new_order;
			b_chngOrder.addEventListener(MouseEvent.MOUSE_DOWN, reset_order);
			b_chngOrder.textColor = Colours.DULL;
			b_chngOrder.borderColor = Colours.DULL;
			b_chngOrder.border = true;;
			for (var i:int = 0; i < 4; i++)
			{
				//order[i] = new_order.charAt[i];
			}
		}
		
		private function set_up(e:MouseEvent):void
		{
			
			var i:int = 0;
			while (order[i] != 't' && i < 4)
			{
				i++;
			}
			order[i] = order[0];
			order[0] = 't';
			new_order = new_order + "t";
			order.pop();
			b_up.text = count + "\n Up ";
			count++;
			b_up.removeEventListener(MouseEvent.MOUSE_DOWN, set_up);
			b_up.textColor = Colours.HIGHLIGHT;
			b_up.border = false;
			
			if (count > 4)
			{
				set_order();
			}
		
		}
		
		private function set_down(e:MouseEvent):void
		{
			
			var i:int = 0;
			while (order[i] != 'b' && i < 4)
			{
				i++;
			}
			order[i] = order[0];
			order[0] = 'b';
			new_order = new_order + "b";
			order.pop();
			b_down.text = count + "\nDown";
			count++;
			b_down.removeEventListener(MouseEvent.MOUSE_DOWN, set_down);
			b_down.textColor = Colours.HIGHLIGHT;
			b_down.border = false;
			
			if (count > 4)
			{
				set_order();
			}
		
		}
		
		private function set_left(e:MouseEvent):void
		{
			
			var i:int = 0;
			while (order[i] != 'l' && i < 4)
			{
				i++;
			}
			order[i] = order[0];
			order[0] = 'l';
			new_order = new_order + "l";
			order.pop();
			b_left.text = count + "\nLeft";
			count++;
			b_left.removeEventListener(MouseEvent.MOUSE_DOWN, set_left);
			b_left.textColor = Colours.HIGHLIGHT;
			b_left.border = false;
			
			if (count > 4)
			{
				set_order();
			}
		
		}
		
		private function set_right(e:MouseEvent):void
		{
			
			var i:int = 0;
			while (order[i] != 'r' && i < 4)
			{
				i++;
			}
			order[i] = order[0];
			order[0] = 'r';
			new_order = new_order + "r";
			order.pop();
			b_right.text = count + "\nRight";
			count++;
			b_right.removeEventListener(MouseEvent.MOUSE_DOWN, set_right);
			b_right.textColor = Colours.HIGHLIGHT;
			b_right.border = false;
			
			if (count > 4)
			{
				set_order();
			}
		
		}
	
	}

}
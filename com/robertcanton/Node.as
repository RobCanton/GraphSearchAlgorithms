package com.robertcanton {
	
	import com.robertcanton.Colours;
	import com.robertcanton.Point;
	import flash.display.Sprite;
	import flash.events.MouseEvent;	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Node extends Sprite 
	{
		public var top_node:Node;
		public var rig_node:Node;
		public var bot_node:Node;
		public var lef_node:Node;
		
		public var nodeID:int;
		
		private var size:int;
		
		public var isWall:Boolean;
		public var visited:Boolean;
		public var coord:Point;
		public var start_dist:int;
		public var goal_dist:int;
		
		public var label_num:TextField;
		public var label_goal_dist:TextField;
		public var label_start_dist:TextField;
		public var label_f_value:TextField;
		
		private var labelFont = new CourierNew();
		private var labelFormat:TextFormat = new TextFormat();
		private var labelFormat2:TextFormat = new TextFormat();
		
		public function Node (_id:int,_size:int,_isWall:Boolean, _i:int, _j:int) {
			//trace("Node.as is running...");
			nodeID = _id;
			size = _size;
			isWall = _isWall;
			
			visited = false;
			coord = new Point(_i, _j);
			goal_dist = 999;

			top_node = null;
			rig_node = null;
			bot_node = null;
			lef_node = null;
			
			labelFormat.size = size / 4;
			labelFormat.align = TextFormatAlign.LEFT;
			labelFormat.font = labelFont.fontName;
			labelFormat.bold = true;
			
			labelFormat2.size = size / 4;
			labelFormat2.align = TextFormatAlign.RIGHT;
			labelFormat2.font = labelFont.fontName;
			labelFormat2.bold = true;
		}

		public function col_Node (_col:uint):void {
			this.graphics.clear();
			this.graphics.lineStyle(1,0x000000,0.5);
			this.graphics.beginFill(_col, 1);
			this.graphics.drawRect(0, 0, size, size);
			this.graphics.endFill();
			
		}
		
		public function col_alpha_Node (_col:uint,_a:Number):void {
			this.graphics.clear();
			this.graphics.lineStyle(1,0x000000,0.5);
			this.graphics.beginFill(_col, _a);
			this.graphics.drawRect(0, 0, size, size);
			this.graphics.endFill();
			
		}
		
		public function drawNode ():void {

			this.graphics.lineStyle(1,0x000000,0.5);
			this.graphics.beginFill(Colours.BLANK_NODE, 1);
			this.graphics.drawRect(0, 0, size, size);
			this.graphics.endFill();
			
			label_num = drawLabel(Colours.HIGHLIGHT,labelFormat);
			
			label_goal_dist = drawLabel(Colours.GREEN,labelFormat);
			label_goal_dist.y =  size * 0.60;
			
			label_start_dist = drawLabel(Colours.GREEN,labelFormat2);
			label_start_dist.x = this.width - label_start_dist.width;
			
			label_f_value = drawLabel(Colours.PURP, labelFormat2);
			label_f_value.y = size * 0.60;
			label_f_value.x = this.width - label_f_value.width;
			
			this.addChild(label_num);
			this.addChild(label_goal_dist);
			this.addChild(label_start_dist);
			this.addChild(label_f_value);
		}
		
		public function isVisitable():Boolean
		{
			var value:Boolean = true;
			if (visited || isWall)
			{
				value = false;
			}
			return value;
		}
		
		public function drawLabel(c:uint,f:TextFormat):TextField
		{
			
			var temp:TextField;
			temp = new TextField();
			temp.textColor = c;
			temp.defaultTextFormat = f;
			temp.text = "";
			temp.width = size;
			temp.height = size;
			temp.selectable = false;
			
			return temp;
		}
		
		public function updateLabel(s:String):void
		{
			label_num.text = s;
		}
	}
	
}
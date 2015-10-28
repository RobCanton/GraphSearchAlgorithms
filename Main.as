package 
{
	import com.robertcanton.SelectionBar;
	import com.robertcanton.Graph;
	import com.robertcanton.NavBar;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Main extends Sprite 
	{
		protected var graph:Graph;
		protected var navBar:NavBar;
		protected var selectionBar:SelectionBar;
		
		public function Main():void 
		{
			trace("Main.as is running...");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			
			// entry point
			
			launch();
		}
		
		private function launch():void {
			var size:int = stage.stageWidth / 12;
			var rows:int = (stage.stageHeight * 0.85) / size ;
			var cols:int = stage.stageWidth / size;
			graph = new Graph(rows, cols, size);
			graph.y = stage.stageHeight * 0.05;
			addChild(graph);
		
			var remainderHeight:Number = (rows * size) + graph.y;
			selectionBar = new SelectionBar(graph, stage.stageHeight - remainderHeight, stage.stageWidth);
			selectionBar.y = remainderHeight;
			addChild(selectionBar);
			trace("RemHeight " + remainderHeight);
			trace("to " + (stage.stageHeight - remainderHeight));
			trace("SelHeight " + selectionBar.HEIGHT);
			
			navBar = new NavBar(graph, stage.stageHeight * 0.05, stage.stageWidth,stage.stageHeight,selectionBar);
			navBar.createBar();
			addChild(navBar);
			
			
			
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}
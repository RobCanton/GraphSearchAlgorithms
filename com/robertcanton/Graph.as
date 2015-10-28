package com.robertcanton
{
	import com.robertcanton.AStarSearch;
	import com.robertcanton.BestFirstSearch;
	import com.robertcanton.BreadthFirstSearch;
	import com.robertcanton.Node;
	import com.robertcanton.DepthFirstSearch;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Graph extends Sprite
	{
		private var numRows:int;
		private var numCols:int;
		public var numNodes:int;
		private var nodeSize:int;
		
		private var nodesArray:Array = new Array();
		private var colsArray:Array = new Array();
		private var colSwitch:Boolean;
		
		private var startNode:Node;
		private var endNode:Node;
		private var search_AFS:AStarSearch;
		private var search_BESTFS:BestFirstSearch;
		private var search_BFS:BreadthFirstSearch;
		private var search_DFS:DepthFirstSearch;
		private var bg:Sprite = new Sprite;
		
		public var nodeType:int;
		public var searchType:int;
		
		public var dist_type:int = 0;
		public var default_order:String = "trbl";
		
		public var numLabel_flag:Boolean = true;
		public var goalDistLabel_flag:Boolean = false;
		public var startLabel_flag:Boolean = false;
		public var fValueLabel_flag:Boolean = false;
		
		public function Graph(_rows:int, _cols:int, _nodeSize:int)
		{
			trace("Graph.as is running...");
			numRows = _rows;
			numCols = _cols;
			
			nodeSize = _nodeSize;
			numNodes = 0;
			startNode = null;
			endNode = null;
			
			nodeType = 0;
			searchType = 0;
			bg.graphics.clear();
			this.addChild(bg);
			initGraph();
		}
		
		private function initGraph():void
		{
			for (var row = 0; row < numRows; row++)
			{
				//Make an array of columns for each row
				colsArray = new Array();
				
				for (var col = 0; col < numCols; col++)
				{
					colsArray.push(null);
				}
				
				nodesArray.push(colsArray);
			}
			
			drawGraph();
		}
		
		private function drawGraph():void
		{
			bg.graphics.clear();
			bg.graphics.beginFill(Colours.BACKGROUND, 1);
			bg.graphics.drawRect(0, 0, nodeSize * numCols, nodeSize * numRows);
			bg.graphics.endFill();
			trace("Drawing Graph...\n" + "Rows: " + numRows + " | Cols: " + numCols);
			var i:int;
			var j:int;
			var tempNode:Node;
			
			for (i = 0; i < numRows; i++)
			{
				
				for (j = 0; j < numCols; j++)
				{
					//trace("Node(" + i + "," + j + ")");
					tempNode = new Node(numNodes, nodeSize, false, i, j);
					
					numNodes += 1;
					tempNode.y = i * nodeSize;
					tempNode.x = j * nodeSize;
					this.addChild(tempNode);
					nodesArray[i][j] = tempNode;
					nodesArray[i][j].addEventListener(MouseEvent.MOUSE_OVER, setNode);
				}
			}
			
			//Top Left
			nodesArray[0][0].rig_node = nodesArray[0][1];
			nodesArray[0][0].bot_node = nodesArray[1][0];
			nodesArray[0][0].drawNode();
			
			//Top Right
			nodesArray[0][numCols - 1].lef_node = nodesArray[0][numCols - 2];
			nodesArray[0][numCols - 1].bot_node = nodesArray[1][numCols - 1];
			nodesArray[0][numCols - 1].drawNode();
			
			//Bottom Left
			nodesArray[numRows - 1][0].rig_node = nodesArray[numRows - 1][1];
			nodesArray[numRows - 1][0].top_node = nodesArray[numRows - 2][0];
			nodesArray[numRows - 1][0].drawNode();
			
			//Bottom Right
			nodesArray[numRows - 1][numCols - 1].lef_node = nodesArray[numRows - 1][numCols - 2];
			nodesArray[numRows - 1][numCols - 1].top_node = nodesArray[numRows - 2][numCols - 1];
			nodesArray[numRows - 1][numCols - 1].drawNode();
			
			//Top Side
			for (i = 1; i < numCols - 1; i++)
			{
				nodesArray[0][i].rig_node = nodesArray[0][i + 1];
				nodesArray[0][i].lef_node = nodesArray[0][i - 1];
				nodesArray[0][i].bot_node = nodesArray[1][i];
				nodesArray[0][i].drawNode();
			}
			//Bottom Side
			for (i = 1; i < numCols - 1; i++)
			{
				nodesArray[numRows - 1][i].rig_node = nodesArray[numRows - 1][i + 1];
				nodesArray[numRows - 1][i].lef_node = nodesArray[numRows - 1][i - 1];
				nodesArray[numRows - 1][i].top_node = nodesArray[numRows - 2][i];
				nodesArray[numRows - 1][i].drawNode();
			}
			
			//Right Side
			for (i = 1; i < numRows - 1; i++)
			{
				nodesArray[i][numCols - 1].lef_node = nodesArray[i][numCols - 2];
				nodesArray[i][numCols - 1].top_node = nodesArray[i - 1][numCols - 1];
				nodesArray[i][numCols - 1].bot_node = nodesArray[i + 1][numCols - 1];
				nodesArray[i][numCols - 1].drawNode();
			}
			
			//Left Side
			for (i = 1; i < numRows - 1; i++)
			{
				nodesArray[i][0].rig_node = nodesArray[i][1];
				nodesArray[i][0].top_node = nodesArray[i - 1][0];
				nodesArray[i][0].bot_node = nodesArray[i + 1][0];
				nodesArray[i][0].drawNode();
			}
			
			//Middle
			for (i = 1; i < numRows - 1; i++)
			{
				for (j = 1; j < numCols - 1; j++)
				{
					nodesArray[i][j].top_node = nodesArray[i - 1][j];
					nodesArray[i][j].rig_node = nodesArray[i][j + 1];
					nodesArray[i][j].bot_node = nodesArray[i + 1][j];
					nodesArray[i][j].lef_node = nodesArray[i][j - 1];
					nodesArray[i][j].drawNode();
				}
			}
			
			modify_labels(0, true);
			modify_labels(1, false);
			modify_labels(2, false);
			modify_labels(3, false);
			
			search_DFS = new DepthFirstSearch(this, startNode);
			search_BFS = new BreadthFirstSearch(this, startNode);
			search_BESTFS = new BestFirstSearch(this, startNode);
			search_AFS = new AStarSearch(this, startNode);
		}
		
		private function setNode(e:MouseEvent):void
		{
			var tempNode:Node = e.currentTarget as Node;
			
			switch (nodeType)
			{
				case 0: 
					setStartNode(tempNode);
					break;
				case 1: 
					setEndNode(tempNode);
					break;
				case 2: 
					setWallNode(tempNode);
					break;
				case 3: 
					setBlankNode(tempNode);
					break;
			}
		}
		
		private function setStartNode(_node:Node):void
		{
			if ((endNode == null || _node.nodeID != endNode.nodeID) && !_node.isWall)
			{
				if (startNode != null)
				{
					startNode.visited = false;
					startNode.col_Node(Colours.BLANK_NODE);
				}
				startNode = _node;
				startNode.col_Node(Colours.START_NODE);
				startNode.isWall = false;
				
				doSearch();
			}
		}
		
		private function setEndNode(_node:Node):void
		{
			if ((startNode == null || _node.nodeID != startNode.nodeID) && !_node.isWall)
			{
				if (endNode != null)
				{
					
					endNode.visited = false;
					endNode.col_Node(Colours.BLANK_NODE);
				}
				
				endNode = _node;
				endNode.col_Node(Colours.END_NODE);
				endNode.isWall = false;
				
				
				doSearch();
			}
		}
		
		private function setWallNode(_node:Node):void
		{
			if ((startNode == null || _node.nodeID != startNode.nodeID) && (endNode == null || _node.nodeID != endNode.nodeID))
			{
				_node.isWall = true;
				_node.col_Node(Colours.WALL_NODE);
				
				if (_node.visited)
				{
					doSearch();
				}
			}
		}
		
		private function setBlankNode(_node:Node):void
		{
			if (_node.isWall)
			{
				_node.isWall = false;
				_node.col_Node(Colours.BLANK_NODE);
				
				doSearch();
			}
			else if (startNode != null && startNode.nodeID == _node.nodeID)
			{
				
				startNode.col_Node(Colours.BLANK_NODE);
				startNode.isWall = false
				startNode = null;
				resetAllNodes();
			}
			else if (endNode != null && endNode.nodeID == _node.nodeID)
			{
				
				endNode.col_Node(Colours.BLANK_NODE);
				endNode.isWall = false
				endNode = null;
				resetAllNodes();
			}
		}
		
		public function doSearch():void
		{
			if (startNode != null && endNode != null)
			{
				resetAllNodes();
				calc_all_distances();
				//trace(startNode.calc_manhattan_distance(endNode));
				switch (searchType)
				{
					case 0: 
						search_DFS.numVisted = 0;
						search_DFS.endFound = false;
						search_DFS.search(this, startNode, startNode, endNode);
						break;
					case 1: 
						search_BFS.endFound = false;
						search_BFS.search(this, startNode, startNode, endNode);
						break;
					case 2: 
						search_BESTFS.endFound = false;
						search_BESTFS.search(this, startNode, startNode, endNode);
						break;
					case 3: 
						search_AFS.endFound = false;
						search_AFS.search(this, startNode, startNode, endNode);
						break;
				}
				
			}
		}
		
		public function calc_all_distances()
		{
			var i:int;
			var j:int;
			var temp:Node;
			for (i = 0; i < numRows; i++)
			{
				for (j = 0; j < numCols; j++)
				{
					temp = nodesArray[i][j];
					if (dist_type == 0)
					{
						temp.goal_dist = calc_euclidean_distance(temp, endNode);
						temp.start_dist = calc_euclidean_distance(temp, startNode);
					}
					else 
					{
						temp.goal_dist = calc_manhattan_distance(temp, endNode);
						temp.start_dist = calc_manhattan_distance(temp, startNode);
					}
				}
			}
		}
		
		public function calc_manhattan_distance(_n1:Node, _n2:Node):int
		{
			var xDistance:int = Math.abs(_n1.coord.i - _n2.coord.i);
			var yDistance:int = Math.abs(_n1.coord.j - _n2.coord.j);
			return xDistance + yDistance;
		}
		
		public function calc_euclidean_distance(_n1:Node, _n2:Node):int
		{
			var deltaX:int = Math.abs((_n2.coord.i - _n1.coord.i));
			var deltaY:int = Math.abs((_n2.coord.j - _n1.coord.j));
			return Math.sqrt((deltaX * deltaX) + (deltaY * deltaY));
		}
		
		public function getOrder(node:Node, _n:int):Node
		{
			if (_n >= 0 && _n <= 4)
			{
				if (default_order.charAt(_n) == 't')
				{
					return node.top_node;
				}
				if (default_order.charAt(_n) == 'l')
				{
					return node.lef_node;
				}
				if (default_order.charAt(_n) == 'r')
				{
					return node.rig_node;
				}
				if (default_order.charAt(_n) == 'b')
				{
					return node.bot_node;
				}
			}
			return null;
		}
		
		public function resetAllNodes():void
		{
			var i:int;
			var j:int;
			for (i = 0; i < numRows; i++)
			{
				for (j = 0; j < numCols; j++)
				{
					nodesArray[i][j].visited = false;
					nodesArray[i][j].label_num.text = "";
					nodesArray[i][j].label_goal_dist.text = "";
					nodesArray[i][j].label_start_dist.text = "";
					nodesArray[i][j].label_f_value.text = "";
					if ((endNode == null || nodesArray[i][j].nodeID != endNode.nodeID)&& (startNode == null || nodesArray[i][j].nodeID != startNode.nodeID) && !nodesArray[i][j].isWall)
					{
						nodesArray[i][j].col_Node(Colours.BLANK_NODE);
					}
				}
			}
		}
		
		public function killListeners():void
		{
			var i:int;
			var j:int;
			for (i = 0; i < numRows; i++)
			{
				for (j = 0; j < numCols; j++)
				{
					nodesArray[i][j].removeEventListener(MouseEvent.MOUSE_OVER, setNode);
				}
			}
		}
		public function reviveListeners():void
		{
			var i:int;
			var j:int;
			for (i = 0; i < numRows; i++)
			{
				for (j = 0; j < numCols; j++)
				{
					nodesArray[i][j].addEventListener(MouseEvent.MOUSE_UP, setNode);
				}
			}
		}
		
		public function removeAllNodes():void
		{
			var i:int;
			var j:int;
			for (i = 0; i < numRows; i++)
			{
				for (j = 0; j < numCols; j++)
				{
					trace("Removing Node [" + i + "][" + j + "]");
					nodesArray[i][j].top_node = null;
					nodesArray[i][j].rig_node = null;
					nodesArray[i][j].bot_node = null;
					nodesArray[i][j].lef_node = null;
					
					this.removeChild(nodesArray[i][j]);
					nodesArray[i][j] = null;
				}
			}
		}
		
		public function modify_labels(_type:int,a:Boolean):void
		{
			var i:int;
			var j:int;
			for (i = 0; i < numRows; i++)
			{
				for (j = 0; j < numCols; j++)
				{
					trace("Modifying Node [" + i + "][" + j + "]");
					if (_type == 0)
					{
						nodesArray[i][j].label_num.visible = a;
					}
					if (_type == 1)
					{
						nodesArray[i][j].label_goal_dist.visible = a;
					}
					if (_type == 2)
					{
						nodesArray[i][j].label_start_dist.visible = a;
					}
					if (_type == 3)
					{
						nodesArray[i][j].label_f_value.visible = a;
					}
				}
			}
		}
		
		public function resetGraph(_rows:int, _cols:int, _nodeSize:int):void
		{
			killListeners();
			//resetAllNodes();
			startNode = null;
			endNode = null;
			
			removeAllNodes();
			
			numRows = _rows;
			numCols = _cols;
			numNodes = 0;
			nodeSize = _nodeSize;
			initGraph();
			
			
			
		}
	}

}
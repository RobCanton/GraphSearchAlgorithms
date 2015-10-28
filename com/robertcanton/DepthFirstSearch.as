package com.robertcanton
{
	import com.robertcanton.Colours;
	import com.robertcanton.Graph;
	import com.robertcanton.Node;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class DepthFirstSearch
	{
		private var g:Graph;
		private var start:Node;
		public var endFound:Boolean;
		
		public var numVisted:int;
		
		public function DepthFirstSearch(_graph:Graph, _start:Node):void
		{
			g = _graph
			start = _start;
			numVisted = 0;
		}
		
		public function search(g:Graph, n:Node, start:Node, end:Node):void
		{
			if (!endFound)
			{
				n.visited = true;
				if (n.nodeID == end.nodeID)
				{
					trace("Found End: " + n.nodeID);
					endFound = true;
					numVisted = 0;
				}
				else if (n != null && !n.isVisitable())
				{
					numVisted += 1;
					n.label_num.text = String(numVisted);
					n.label_goal_dist.text = String(n.goal_dist);
					n.label_start_dist.text = String(n.start_dist);
					n.label_f_value.text = String(n.start_dist + n.goal_dist);
					
					//Colour Node if it is not the Start or End Node
					if (n.nodeID != start.nodeID && n.nodeID != end.nodeID)
					{
						trace(numVisted + "/" + g.numNodes);
						n.col_alpha_Node(Colours.VISIT_NODE, 1 - numVisted / g.numNodes);
					}
					
					var n1:Node = g.getOrder(n, 0);
					var n2:Node = g.getOrder(n, 1);
					var n3:Node = g.getOrder(n, 2);
					var n4:Node = g.getOrder(n, 3);
					
					if (n1 != null && n1.isVisitable())
					{
						search(g, n1, start, end);
					}
					if (n2 != null && n2.isVisitable())
					{
						search(g, n2, start, end);
					}
					
					if (n3 != null && n3.isVisitable())
					{
						search(g, n3, start, end);
					}
					if (n4 != null && n4.isVisitable())
					{
						search(g, n4, start, end);
					}
				}
			}
		}
		
	}

}
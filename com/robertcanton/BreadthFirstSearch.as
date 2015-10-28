package com.robertcanton
{
	import com.greensock.TweenLite;
	import com.robertcanton.Colours;
	import com.robertcanton.Graph;
	import com.robertcanton.Node;
	import com.robertcanton.Queue;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class BreadthFirstSearch
	{
		private var g:Graph;
		private var start:Node;
		public var endFound:Boolean;
		private var numVisted:int;
		private var n1:Node;
		private var n2:Node;
		private var n3:Node;
		private var n4:Node;
		
		private var Q:Queue;
		
		public function BreadthFirstSearch(_graph:Graph, _start:Node):void
		{
			g = _graph
			start = _start;
			numVisted = 0;
		}
		
		public function search(g:Graph, n:Node, start:Node, end:Node):void
		{
			Q = new Queue;
			Q.enqueue(n);
			numVisted = 0;
			
			while (!Q.isEmpty() && !endFound)
			{
				var temp:Node = Q.dequeue() as Node;

				if (temp.nodeID == end.nodeID)
				{
					trace("Found End: " + temp.nodeID);
					endFound = true;
					temp.visited = true;
					numVisted = 0;
				}
				else if (temp != null && temp.isVisitable())
				{
					temp.visited = true;
					numVisted += 1;
					temp.label_num.text = String(numVisted);
					temp.label_goal_dist.text = String(temp.goal_dist);
					temp.label_start_dist.text = String(temp.start_dist);
					temp.label_f_value.text = String(temp.start_dist + temp.goal_dist);
					if (temp.nodeID != start.nodeID)
					{
						trace (numVisted + " | " + g.numNodes);
						temp.col_alpha_Node(Colours.VISIT_NODE,1 - numVisted / g.numNodes);
					}
					
					n1 = g.getOrder(temp, 0);
					n2 = g.getOrder(temp, 1);
					n3 = g.getOrder(temp, 2);
					n4 = g.getOrder(temp, 3);
					
					if (n1 != null && n1.isVisitable())
					{
						Q.enqueue(n1);
					}
					
					if (n2 != null && n2.isVisitable())
					{
						Q.enqueue(n2);
					}
					
					if (n3 != null && n3.isVisitable())
					{
						Q.enqueue(n3);
					}
					
					if (n4 != null && n4.isVisitable())
					{
						Q.enqueue(n4);
					}
					 
				}
				
			}
		
		}
		
	}

}
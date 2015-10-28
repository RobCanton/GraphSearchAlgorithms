package com.robertcanton
{
	import com.robertcanton.Colours;
	import com.robertcanton.Graph;
	import com.robertcanton.Node;
	import com.robertcanton.Heap;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class AStarSearch
	{
		private var g:Graph;
		private var start:Node;
		public var endFound:Boolean;
		private var numVisted:int;
		private var n1:Node;
		private var n2:Node;
		private var n3:Node;
		private var n4:Node;
		
		private var H:Heap;
		
		public function AStarSearch(_graph:Graph, _start:Node):void
		{
			g = _graph
			start = _start;
			numVisted = 0;
		}
		
		public function search(g:Graph, n:Node, start:Node, end:Node):void
		{	
			
			H = new Heap(g.numNodes, compareDistances);
			H.put(n);
			
			numVisted = 0;
			
			while (!H.isEmpty() && !endFound)
			{
				var temp:Node = H.pop() as Node;
				if (temp.nodeID == end.nodeID)
				{
					trace("Found End: " + temp.nodeID);
					endFound = true;
					numVisted = 0;
					temp.visited  = true;
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
						temp.col_alpha_Node(Colours.VISIT_NODE,1 - numVisted / g.numNodes);
					}
					
					n1 = g.getOrder(temp, 0);
					n2 = g.getOrder(temp, 1);
					n3 = g.getOrder(temp, 2);
					n4 = g.getOrder(temp, 3);
					
					if (n1 != null && n1.isVisitable())
					{
						H.put(n1);
					}
					if (n2 != null && n2.isVisitable())
					{
						H.put(n2);
					}
					if (n3 != null && n3.isVisitable())
					{
						H.put(n3);
					}
					if (n4 != null && n4.isVisitable())
					{
						H.put(n4);
					}

				}
			}
		}
		private function compareDistances(a:Node, b:Node):int
		{
			return (b.goal_dist + b.start_dist) - (a.goal_dist + a.start_dist);
		}
	}

}
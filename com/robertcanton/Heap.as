package com.robertcanton
{
        /**
         * A heap is a special kind of binary tree in which every node is greater
         * than all of its children. The implementation is based on an arrayed
         * binary tree. It can be used as an efficient priority queue.
         * 
         * @see PriorityQueue
         */
        public class Heap
        {
                public var _heap:Array;
                
                private var _size:int;
                private var _count:int;
                private var _compare:Function;
                
                /**
                 * Initializes a new heap.
                 * 
                 * @param size The heap's maximum capacity.
                 * @param compare A comparison function for sorting the heap's data.
                 *                If no function is passed, the heap uses a function for
                 *                comparing numbers.
                 */
                public function Heap(size:int, compare:Function = null)
                {
                        _heap = new Array(_size = size + 1);
                        _count = 0;
                        
                        if (compare == null)
                                _compare = function(a:Node, b:Node):int { return b.goal_dist - a.goal_dist; };
                        else
                                _compare = compare;
                }
                
                /**
                 * The heap's front item.
                 */
                public function peek():Node
                {
                        return _heap[1];
                }
                
                /**
                 * The heap's maximum capacity.
                 */
                public function maxSize():int
                {
                        return _size;
                }
                
                /**
                 * add some data.
                 * 
                 * @param obj The data to enqueue.
                 * @return False if the queue is full, otherwise true.
                 */
                public function put(obj:Node):Boolean
                {
                        if (_count + 1 < _size)
                        {
                                _heap[++_count] = obj;
                                
                                var i:int = _count;
                                var parent:int = i / 2;        // = i / 2
                                var tmp:Node = _heap[i];
                                var v:Node; 
                                
                                if (_compare != null)
                                {
                                        while (parent > 0)
                                        {
                                                 v = _heap[parent];
                                                if (_compare(tmp, v) > 0)
                                                {
                                                        _heap[i] = v;
                                                        i = parent;
                                                        parent /= 2;
                                                }
                                                else break;
                                        }
                                }
                                else
                                {
                                        while (parent > 0)
                                        {
                                                v = _heap[parent];
                                                if (tmp.goal_dist - v.goal_dist > 0)
                                                {
                                                        _heap[i] = v;
                                                        i = parent;
                                                        parent /= 2;
                                                }
                                                else break;
                                        }
                                }
                                
                                _heap[i] = tmp;
                                return true;
                        }
                        return false;
                }
                
                /**
                 * Dequeues and returns the front item.
                 * 
                 * @return The heap's front item or null if it is empty.
                 */
                public function pop():Node
                {
                        if (_count >= 1)
                        {
                                var o:Node = _heap[1];
                                
                                _heap[1] = _heap[_count];
                                delete _heap[_count];
                                
                                var i:int = 1;
                                var child:int = i * 2;
                                var tmp:Node = _heap[i];
                                var v:Node;
                                
                                if (_compare != null)
                                {
                                        while (child < _count)
                                        {
                                                if (child < _count - 1)
                                                {
                                                        if (_compare(_heap[child], _heap[int(child + 1)]) < 0)
                                                                child++;
                                                }
                                                v = _heap[child];
                                                if (_compare(tmp, v) < 0)
                                                {
                                                        _heap[i] = v;
                                                        i = child;
                                                        child *= 2;
                                                }
                                                else break;
                                        }
                                }
                                else
                                {
                                        while (child < _count)
                                        {
                                                if (child < _count - 1)
                                                {
                                                        if (_heap[child] - _heap[int(child + 1)] < 0)
                                                                child++;
                                                }
                                                v = _heap[child];
                                                if (tmp.goal_dist - v.goal_dist < 0)
                                                {
                                                        _heap[i] = v;
                                                        i = child;
                                                        child *= 2;
                                                }
                                                else break;
                                        }
                                }
                                _heap[i] = tmp;
                                
                                _count--;
                                return o;
                        }
                        return null;
                }
                
                /**
                 * Checks if a given item exists.
                 * 
                 * @return True if the item is found, otherwise false.
                 */
                public function contains(obj:Node):Boolean
                {
                        for (var i:int = 1; i <= _count; i++)
                        {
                                if (_heap[i] === obj)
                                        return true;
                        }
                        return false;
                }
                
                /**
                 * @inheritDoc
                 */
                public function clear():void
                {
                        _heap = new Array(_size);
                        _count = 0;
                }
                
                /**
                 * @inheritDoc
                 */
                public function get size():int
                {
                        return _count;
                }
                
                /**
                 * @inheritDoc
                 */
                public function isEmpty():Boolean
                {
                        return _heap[1] == null;
                }
                
                /**
                 * @inheritDoc
                 */
                public function toArray():Array
                {
                        return _heap.slice(1, _count + 1);
                }
                
                /**
                 * Prints out a string representing the current object.
                 * 
                 * @return A string representing the current object.
                 */
                public function toString():String
                {
                        return "[Heap, size=" + _size +"]";
                }
                
                /**
                 * Prints out all elements (for debug/demo purposes).
                 * 
                 * @return A human-readable representation of the structure.
                 */
                public function dump():String
                {
                        var s:String = "Heap\n{\n";
                        var k:int = _count + 1;
                        for (var i:int = 1; i < k; i++)
                                s += "\t" + "NodeID: " + _heap[i].nodeID + " | Distance: " + _heap[i].goal_dist + "\n";
                        s += "\n}";
                        return s;
                }
        }
}
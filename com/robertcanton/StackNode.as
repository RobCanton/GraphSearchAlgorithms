package com.robertcanton
{
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	internal final class DataNode
    {
        public var value:Object;
        public var next:StackNode;

        public function StackNode(value:Object):void
        {
            this.value = value;
        }
    }
	
}
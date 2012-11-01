package org.libra.ui.starling.core {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class InvalidationFlag
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public final class InvalidationFlag {
		
		public static const ALL:int = -1;
		
		public static const SIZE:int = 0;
		
		public static const STYLE:int = 1;
		
		public static const STATE:int = 2;
		
		public static const DATA:int = 3;
		
		public static const TEXT:int = 4;
		
		//private var size:Boolean;
		//
		//private var style:Boolean;
		//
		//private var state:Boolean;
		//
		//private var data:Boolean;
		//
		//private var text:Boolean;
		
		private var invalidationList:Array;
		
		public function InvalidationFlag() {
			invalidationList = [false, false, false, false, false];
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setInvalid(val:int):void {
			if(val > -1)
				this.invalidationList[val] = true;
			else {
				for (var i:* in this.invalidationList) 
					this.invalidationList[i] = true;
			}
		}
		
		public function isSizeInvalid():Boolean {
			//return this.size;
			return this.invalidationList[SIZE];
		}
		
		//public function setSizeInvalid(val:Boolean):void {
			//this.size = val;
		//}
		
		public function isStyleInvalid():Boolean {
			//return this.style;
			return this.invalidationList[STYLE];
		}
		
		//public function setStyleInvalid(val:Boolean):void {
			//this.style = val;
		//}
		
		public function isStateInvalid():Boolean {
			//return this.state;
			return this.invalidationList[STATE];
		}
		
		//public function setStateInvalid(val:Boolean):void {
			//this.state = val;
		//}
		
		public function isDataInvalid():Boolean {
			//return this.data;
			return this.invalidationList[DATA];
		}
		
		//public function setDataInvalid(val:Boolean):void {
			//this.data = val;
		//}
		
		public function isTextInvalid():Boolean {
			//return this.text;
			return this.invalidationList[TEXT];
		}
		
		//public function setTextInvalid(val:Boolean):void {
			//this.text = val;
		//}
		
		public function reset():void {
			for (var i:* in this.invalidationList)
				this.invalidationList[i] = false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

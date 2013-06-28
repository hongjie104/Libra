package org.libra.ui.flash.components {
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JCheckBoxGroup
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public class JCheckBoxGroup extends Container {
		
		/**
		 * CheckBox的数组
		 */
		private var $checkBoxList:Vector.<JCheckBox>;
		
		private var $orientation:int;
		
		private var $gap:int;
		
		private var selectedBox:JCheckBox;
		
		/**
		 * N个CheckBox的集合
		 * @param	x
		 * @param	y
		 * @param	orientation 方向 0：水平 1：垂直
		 * @see org.libra.ui.Constants
		 */
		public function JCheckBoxGroup(x:int = 0, y:int = 0, orientation:int = 0, gap:int = 5) { 
			super(x, y);
			this.$orientation = orientation;
			this.$gap = gap;
			$checkBoxList = new Vector.<JCheckBox>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function appendAllCheckBox(...rest):void {
			for each(var box:JCheckBox in rest) 
				this.appendCheckBox(box);
		}
		
		public function appendCheckBox(checkBox:JCheckBox):void {
			if (this.$checkBoxList.indexOf(checkBox) == -1) {
				var l:int = $checkBoxList.length;
				if (l == 0) this.setSelectedCheckBox(checkBox);
				$checkBoxList[l] = checkBox;
				checkBox.setCheckBoxGroup(this);
				if (checkBox.selected) this.setSelectedCheckBox(checkBox);
				this.invalidate(InvalidationFlag.SIZE);
			}
		}
		
		public function removeAllCheckBox(...rest):void {
			for each(var box:JCheckBox in rest) 
				this.removeCheckBox(box);
		}
		
		public function removeCheckBox(checkBox:JCheckBox):void {
			var index:int = this.$checkBoxList.indexOf(checkBox);
			if (index != -1) {
				this.$checkBoxList.splice(index, 1);
				this.remove(checkBox);
				if (selectedBox == checkBox) this.setSelectedCheckBox($checkBoxList.length ? $checkBoxList[0] : null);
				this.invalidate(InvalidationFlag.SIZE);
			}
		}
		
		public function clearCheckBox():void {
			var i:int = $checkBoxList.length;
			while (--i > -1)
				this.remove($checkBoxList[i]);
				
			this.$checkBoxList.length = 0;
			this.selectedBox = null;
		}
		
		public function setSelectedCheckBox(checkBox:JCheckBox):void {
			this.selectedBox = checkBox;
			invalidate(InvalidationFlag.STATE);
		}
		
		public function setCheckBoxUnselected(except:JCheckBox):void {
			var i:int = $checkBoxList.length;
			while (--i > -1) {
				if (this.$checkBoxList[i] == except) continue;
				this.$checkBoxList[i].selected = false;
			}
		}
		
		public function set gap(val:int):void {
			this.$gap = val;
			this.invalidate(InvalidationFlag.SIZE);
		}
		
		override public function dispose():void {
			super.dispose();
			var i:int = $checkBoxList.length;
			while (--i > -1) {
				$checkBoxList[i].dispose();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function resize():void {
			var preCheckBox:JCheckBox;
			for each(var box:JCheckBox in this.$checkBoxList) {
				box.setLocation($orientation == Constants.HORIZONTAL ? (preCheckBox ? preCheckBox.width + preCheckBox.x + $gap : 0) : 0, 
					$orientation == Constants.HORIZONTAL ? 0 : (preCheckBox ? preCheckBox.height + preCheckBox.y + $gap : 0));
				preCheckBox = box;
			}
		}
		
		override protected function refreshState():void {
			if(this.selectedBox) this.selectedBox.selected = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
package org.libra.ui.components {
	import org.libra.ui.base.Container;
	import org.libra.ui.Constants;
	
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
		private var checkBoxList:Vector.<JCheckBox>;
		
		private var orientation:int;
		
		private var gap:int;
		
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
			this.orientation = orientation;
			this.gap = gap;
			checkBoxList = new Vector.<JCheckBox>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function appendAllCheckBox(...rest):void {
			for (var i:* in rest) 
				this.appendCheckBox(rest[i]);
		}
		
		public function appendCheckBox(checkBox:JCheckBox):void {
			if (this.checkBoxList.indexOf(checkBox) == -1) {
				var l:int = checkBoxList.length;
				if (l == 0) this.setSelectedCheckBox(checkBox);
				checkBoxList[l] = checkBox;
				checkBox.setCheckBoxGroup(this);
				this.append(checkBox);
				if (checkBox.isSelected()) this.setSelectedCheckBox(checkBox);
				this.invalidate();
			}
		}
		
		public function removeAllCheckBox(...rest):void {
			for(var i:* in rest)
				this.removeCheckBox(rest[i]);
		}
		
		public function removeCheckBox(checkBox:JCheckBox):void {
			var index:int = this.checkBoxList.indexOf(checkBox);
			if (index != -1) {
				this.checkBoxList.splice(index, 1);
				this.remove(checkBox);
				if (selectedBox == checkBox) this.setSelectedCheckBox(checkBoxList.length ? checkBoxList[0] : null);
				this.invalidate();
			}
		}
		
		public function clearCheckBox():void {
			for (var i:* in this.checkBoxList)
				this.remove(checkBoxList[i]);
			this.checkBoxList.length = 0;
			this.selectedBox = null;
			this.invalidate();
		}
		
		public function setSelectedCheckBox(checkBox:JCheckBox):void {
			this.selectedBox = checkBox;
		}
		
		public function setCheckBoxUnselected(except:JCheckBox):void {
			for (var i:* in this.checkBoxList) {
				if (this.checkBoxList[i] == except) continue;
				this.checkBoxList[i].setSelected(false);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function render():void {
			super.render();
			var preCheckBox:JCheckBox;
			for (var i:* in this.checkBoxList) {
				checkBoxList[i].setLocation(orientation == Constants.HORIZONTAL ? (preCheckBox ? preCheckBox.getWidth() + preCheckBox.x + gap : 0) : 0, 
					orientation == Constants.HORIZONTAL ? 0 : (preCheckBox ? preCheckBox.getHeight() + preCheckBox.y + gap : 0));
				preCheckBox = checkBoxList[i];
			}
			if(this.selectedBox) this.selectedBox.setSelected(true);
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
package org.libra.ui.starling.component {
	import org.libra.ui.Constants;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.starling.core.Container;
	
	/**
	 * <p>
	 * 选择框的组群，用来实现单选的功能
	 * </p>
	 *
	 * @class JCheckBoxGroup
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class JCheckBoxGroup extends Container {
		
		/**
		 * CheckBox的数组
		 * @private
		 */
		private var checkBoxList:Vector.<JCheckBox>;
		
		/**
		 * CheckBox的排列方向
		 * 两种值：水平、垂直
		 * @private
		 * @default org.libra.ui.Constants.HORIZONTAL 
		 * @see org.libra.ui.Constants
		 */
		private var orientation:int;
		
		/**
		 * CheckBox的排列间隙，单位：像素
		 * @private
		 * @default 5
		 */
		private var gap:int;
		
		/**
		 * 当前是选中状态的JCheckBox
		 * @private
		 */
		private var selectedBox:JCheckBox;
		
		/**
		 * 构造函数
		 * @private
		 * @param	width
		 * @param	height
		 * @param	x
		 * @param	y
		 * @param	orientation
		 * @param	gap
		 */
		public function JCheckBoxGroup(width:int, height:int, x:int = 0, y:int = 0, orientation:int = Constants.HORIZONTAL, gap:int = 5) { 
			super(width, height, x, y);
			this.orientation = orientation;
			this.gap = gap;
			checkBoxList = new Vector.<JCheckBox>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 添加多个JCheckBox
		 * @param	...rest
		 */
		public function appendAllCheckBox(...rest):void {
			for each(var i:JCheckBox in rest) 
				this.appendCheckBox(i);
		}
		
		/**
		 * 添加一个JCheckBox
		 * @param	checkBox
		 */
		public function appendCheckBox(checkBox:JCheckBox):void {
			if (this.checkBoxList.indexOf(checkBox) == -1) {
				var l:int = checkBoxList.length;
				if (l == 0) this.setSelectedCheckBox(checkBox);
				checkBoxList[l] = checkBox;
				checkBox.setCheckBoxGroup(this);
				if (checkBox.isSelected()) this.setSelectedCheckBox(checkBox);
				this.invalidate(InvalidationFlag.SIZE);
			}
		}
		
		/**
		 * 移除多个JCheckBox
		 * @param	...rest
		 */
		public function removeAllCheckBox(...rest):void {
			for each(var i:JCheckBox in rest)
				this.removeCheckBox(i);
		}
		
		/**
		 * 移除一个JCheckBox
		 * @param	checkBox
		 */
		public function removeCheckBox(checkBox:JCheckBox):void {
			var index:int = this.checkBoxList.indexOf(checkBox);
			if (index != -1) {
				this.checkBoxList.splice(index, 1);
				this.removeChild(checkBox);
				if (selectedBox == checkBox) this.setSelectedCheckBox(checkBoxList.length ? checkBoxList[0] : null);
				this.invalidate(InvalidationFlag.SIZE);
			}
		}
		
		/**
		 * 清除所有的JCheckBox
		 */
		public function clearCheckBox():void {
			for each(var i:JCheckBox in this.checkBoxList)
				this.removeChild(i);
			this.checkBoxList.length = 0;
			this.selectedBox = null;
		}
		
		/**
		 * 设置某个JCheckBox是选中状态
		 * @param	checkBox
		 */
		public function setSelectedCheckBox(checkBox:JCheckBox):void {
			this.selectedBox = checkBox;
			invalidate(InvalidationFlag.STATE);
		}
		
		/**
		 * 设置除了某个JCheckBox之外的所有的JCheckBox为非选中状态
		 * @param	except 不被设置为非选中状态的JCheckBox
		 */
		public function setCheckBoxUnselected(except:JCheckBox):void {
			for each(var i:JCheckBox in this.checkBoxList) {
				if (i == except) continue;
				i.setSelected(false, true);
			}
		}
		
		/**
		 * 设置JCheckBox排列的间隙
		 * @param	val
		 */
		public function setGap(val:int):void {
			this.gap = val;
			this.invalidate(InvalidationFlag.SIZE);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			var preCheckBox:JCheckBox;
			for each(var i:JCheckBox in this.checkBoxList) {
				i.setLocation(orientation == Constants.HORIZONTAL ? (preCheckBox ? preCheckBox.width + preCheckBox.x + gap : 0) : 0, 
					orientation == Constants.HORIZONTAL ? 0 : (preCheckBox ? preCheckBox.height + preCheckBox.y + gap : 0));
				preCheckBox = i;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshState():void {
			if(this.selectedBox) this.selectedBox.setSelected(true);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
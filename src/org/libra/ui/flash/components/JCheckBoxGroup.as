package org.libra.ui.flash.components {
	import org.libra.log4a.Logger;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.interfaces.IComponent;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * 勾选框的组，组内的所有勾选框都是单选的
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
		 * @private
		 */
		private var $checkBoxList:Vector.<JCheckBox>;
		
		/**
		 * 排列方向 0：水平 1：垂直
		 * @private
		 */
		private var $orientation:int;
		
		/**
		 * 间距
		 * @private
		 */
		private var $gap:int;
		
		/**
		 * 当前被勾选的勾选框
		 * @private
		 */
		private var $selectedBox:JCheckBox;
		
		/**
		 * N个CheckBox的集合
		 * @param	width 宽度
		 * @param	height 高度
		 * @default 20
		 * @param	orientation 方向 0：水平 1：垂直
		 * @param	gap 间距
		 * @see org.libra.ui.Constants
		 */
		public function JCheckBoxGroup(width:int = 200, height:int = 20, orientation:int = 0, gap:int = 50) { 
			super();
			//自己是不需要响应鼠标事件的
			mouseEnabled = false;
			this.$orientation = orientation;
			this.$gap = gap;
			$checkBoxList = new Vector.<JCheckBox>();
			setSize(width, height);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 * @param	child
		 * @return
		 */
		override public function append(child:IComponent):IComponent {
			return child is JCheckBox ? this.appendCheckBox(child as JCheckBox) : super.append(child);
		}
		
		/**
		 * 添加N个JCheckBox
		 * @param	...rest
		 */
		public function appendAllCheckBox(...rest):void {
			for each(var box:JCheckBox in rest) 
				this.appendCheckBox(box);
		}
		
		/**
		 * 添加一个JCheckBox
		 * @param	checkBox
		 */
		public function appendCheckBox(checkBox:JCheckBox):IComponent {
			if (this.$checkBoxList.indexOf(checkBox) == -1) {
				var l:int = $checkBoxList.length;
				$checkBoxList[l] = checkBox;
				checkBox.setCheckBoxGroup(this);
				if (checkBox.selected) this.selectedCheckBox = checkBox;
				if (!$selectedBox) this.selectedCheckBox = checkBox;
				this.invalidate(InvalidationFlag.SIZE);
				return super.append(checkBox);
			}
			return null;
		}
		
		override public function remove(child:IComponent, destroy:Boolean = false):IComponent {
			return child is JCheckBox ? removeCheckBox(child as JCheckBox) : super.remove(child, destroy);
		}
		
		/**
		 * 移除指定的一些JCheckBox
		 * @param	...rest
		 */
		public function removeAllCheckBox(...rest):void {
			for each(var box:JCheckBox in rest) 
				this.removeCheckBox(box);
		}
		
		/**
		 * 移除一个JCheckBox
		 * @param	checkBox
		 */
		public function removeCheckBox(checkBox:JCheckBox):IComponent {
			var index:int = this.$checkBoxList.indexOf(checkBox);
			if (index != -1) {
				this.$checkBoxList.splice(index, 1);
				super.remove(checkBox);
				if ($selectedBox == checkBox) this.selectedCheckBox = $checkBoxList.length ? $checkBoxList[0] : null;
				this.invalidate(InvalidationFlag.SIZE);
			}
			return checkBox
		}
		
		/**
		 * 移除所有的JCheckBox
		 */
		public function clearCheckBox():void {
			var i:int = $checkBoxList.length;
			while (--i > -1)
				this.remove($checkBoxList[i]);
				
			this.$checkBoxList.length = 0;
			this.$selectedBox = null;
		}
		
		/**
		 * 赋值当前被勾选的勾选框
		 */
		public function set selectedCheckBox(checkBox:JCheckBox):void {
			if (checkBox) {
				if ($checkBoxList.indexOf(checkBox) == -1) {
					Logger.error(checkBox + '不在组内,不能指定为选择的勾选框');
				}else {
					this.$selectedBox = checkBox;
					invalidate(InvalidationFlag.STATE);
				}
			}else {
				$selectedBox = null;
			}
		}
		
		/**
		 * 将所有的勾选框状态设置为未选中，除了参数指定的JCheckBox
		 * @param	except
		 */
		public function setCheckBoxUnselected(except:JCheckBox):void {
			this.selectedCheckBox = except;
			var i:int = $checkBoxList.length;
			while (--i > -1) {
				if (this.$checkBoxList[i] == except) continue;
				this.$checkBoxList[i].selected = false;
			}
		}
		
		/**
		 * 获取间距
		 */
		public function get gap():int {
			return $gap;
		}
		
		/**
		 * 设置间距
		 */
		public function set gap(val:int):void {
			this.$gap = val;
			this.invalidate(InvalidationFlag.SIZE);
		}
		
		override public function clone():Component {
			return new JCheckBoxGroup($actualWidth, $actualHeight, $orientation, $gap);
		}
		
		/**
		 * @inheritDoc
		 * @return
		 */
		override public function toXML():XML {
			const xml:XML = super.toXML();
			xml.@gap = $gap;
			if (this.$id.indexOf('component') == -1) {
				xml["@var"] = this.$id;
			}
			const l:int = $checkBoxList.length;
			for (var i:int = 0; i < l; i += 1) {
				var tmpXML:XML = this.$checkBoxList[i].toXML();
				if($checkBoxList[i].id.indexOf('component') == -1){
					tmpXML["@var"] = $checkBoxList[i].id;
				}
				xml.appendChild(tmpXML);
			}
			return xml;
		}
		
		/**
		 * @inheritDoc
		 */
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
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			if ($inited) {
				var preCheckBox:JCheckBox;
				for each(var box:JCheckBox in this.$checkBoxList) {
					box.setLocation($orientation == Constants.HORIZONTAL ? (preCheckBox ? preCheckBox.x + $gap : 0) : 0, 
						$orientation == Constants.HORIZONTAL ? 0 : (preCheckBox ? preCheckBox.y + $gap : 0));
					preCheckBox = box;
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshState():void {
			if(this.$selectedBox) this.$selectedBox.selected = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
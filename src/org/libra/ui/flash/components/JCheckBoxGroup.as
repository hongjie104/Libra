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
		private var _checkBoxList:Vector.<JCheckBox>;
		
		/**
		 * 排列方向 0：水平 1：垂直
		 * @private
		 */
		private var _orientation:int;
		
		/**
		 * 间距
		 * @private
		 */
		private var _gap:int;
		
		/**
		 * 当前被勾选的勾选框
		 * @private
		 */
		private var _selectedBox:JCheckBox;
		
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
			this._orientation = orientation;
			this._gap = gap;
			_checkBoxList = new Vector.<JCheckBox>();
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
			if (this._checkBoxList.indexOf(checkBox) == -1) {
				var l:int = _checkBoxList.length;
				_checkBoxList[l] = checkBox;
				checkBox.setCheckBoxGroup(this);
				if (checkBox.selected) this.selectedCheckBox = checkBox;
				if (!_selectedBox) this.selectedCheckBox = checkBox;
				this.invalidate(InvalidationFlag.SIZE);
				return super.append(checkBox);
			}
			return null;
		}
		
		override public function remove(child:IComponent, dispose:Boolean = false):IComponent {
			return child is JCheckBox ? removeCheckBox(child as JCheckBox) : super.remove(child, dispose);
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
			var index:int = this._checkBoxList.indexOf(checkBox);
			if (index != -1) {
				this._checkBoxList.splice(index, 1);
				super.remove(checkBox);
				if (_selectedBox == checkBox) this.selectedCheckBox = _checkBoxList.length ? _checkBoxList[0] : null;
				this.invalidate(InvalidationFlag.SIZE);
			}
			return checkBox
		}
		
		/**
		 * 移除所有的JCheckBox
		 */
		public function clearCheckBox():void {
			var i:int = _checkBoxList.length;
			while (--i > -1)
				this.remove(_checkBoxList[i]);
				
			this._checkBoxList.length = 0;
			this._selectedBox = null;
		}
		
		/**
		 * 赋值当前被勾选的勾选框
		 */
		public function set selectedCheckBox(checkBox:JCheckBox):void {
			if (checkBox) {
				if (_checkBoxList.indexOf(checkBox) == -1) {
					Logger.error(checkBox + '不在组内,不能指定为选择的勾选框');
				}else {
					this._selectedBox = checkBox;
					invalidate(InvalidationFlag.STATE);
				}
			}else {
				_selectedBox = null;
			}
		}
		
		/**
		 * 将所有的勾选框状态设置为未选中，除了参数指定的JCheckBox
		 * @param	except
		 */
		public function setCheckBoxUnselected(except:JCheckBox):void {
			this.selectedCheckBox = except;
			var i:int = _checkBoxList.length;
			while (--i > -1) {
				if (this._checkBoxList[i] == except) continue;
				this._checkBoxList[i].selected = false;
			}
		}
		
		/**
		 * 获取间距
		 */
		public function get gap():int {
			return _gap;
		}
		
		/**
		 * 设置间距
		 */
		public function set gap(val:int):void {
			this._gap = val;
			this.invalidate(InvalidationFlag.SIZE);
		}
		
		override public function clone():Component {
			return new JCheckBoxGroup(_actualWidth, _actualHeight, _orientation, _gap);
		}
		
		/**
		 * @inheritDoc
		 * @return
		 */
		override public function toXML():XML {
			const xml:XML = super.toXML();
			xml.@gap = _gap;
			if (this._id.indexOf('component') == -1) {
				xml["@var"] = this._id;
			}
			const l:int = _checkBoxList.length;
			for (var i:int = 0; i < l; i += 1) {
				var tmpXML:XML = this._checkBoxList[i].toXML();
				if(_checkBoxList[i].id.indexOf('component') == -1){
					tmpXML["@var"] = _checkBoxList[i].id;
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
			var i:int = _checkBoxList.length;
			while (--i > -1) {
				_checkBoxList[i].dispose();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			if (_inited) {
				var preCheckBox:JCheckBox;
				for each(var box:JCheckBox in this._checkBoxList) {
					box.setLocation(_orientation == Constants.HORIZONTAL ? (preCheckBox ? preCheckBox.x + _gap : 0) : 0, 
						_orientation == Constants.HORIZONTAL ? 0 : (preCheckBox ? preCheckBox.y + _gap : 0));
					preCheckBox = box;
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshState():void {
			if(this._selectedBox) this._selectedBox.selected = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
package org.libra.ui.flash.components {
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.interfaces.IComponent;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * 布局容器
	 * </p>
	 *
	 * @class JGroup
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 12/03/2013
	 * @version 1.0
	 * @see
	 */
	public class JGroup extends Container {
		
		/**
		 * 方向
		 * @private
		 * @see org.libra.ui.Constants
		 */
		protected var _orientation:int;
		
		/**
		 * 间距
		 * @private
		 */
		protected var _gap:int;
		
		/**
		 * 垂直对齐方式
		 * @default org.libra.ui.Constants.MIDDLE
		 * @private
		 * @see org.libra.ui.Constants
		 */
		protected var _verticalAlign:int;
		
		/**
		 * 水平对齐方式
		 * @default org.libra.ui.Constants.LEFT
		 * @private
		 * @see org.libra.ui.Constants
		 */
		protected var _horizontalAlign:int;
		
		/**
		 * 左边距
		 * @default 0
		 * @private
		 */
		protected var _paddingLeft:int;
		
		/**
		 * 上边距
		 * @default 0
		 * @private
		 */
		protected var _paddingTop:int;
		
		/**
		 * 右边距
		 * @default 0
		 * @private
		 */
		protected var _paddingRight:int;
		
		/**
		 * 下边距
		 * @default 0
		 * @private
		 */
		protected var _paddingBottom:int;
		
		public function JGroup(x:int = 0, y:int = 0, gap:int = 5, orientation:int = 0) {
			super(x, y, null);
			_gap = gap;
			_orientation = orientation;
			_verticalAlign = Constants.MIDDLE;
			_horizontalAlign = Constants.LEFT;
			this.mouseEnabled = false;
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
			super.append(child);
			this.invalidate(InvalidationFlag.STATE);
			return child;
		}
		
		/**
		 * @inheritDoc
		 * @param	child
		 * @param	destroy
		 * @return
		 */
		override public function remove(child:IComponent, destroy:Boolean = false):IComponent {
			super.remove(child, destroy);
			this.invalidate(InvalidationFlag.STATE);
			return child;
		}
		
		/**
		 * @inheritDoc
		 * @param	w
		 * @param	h
		 */
		override public function setSize(w:int, h:int):void {
			if (_actualWidth != w && _actualHeight != h) {
				super.setSize(w, h);
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function refreshState():void {
			var c:IComponent;
			var tmp:int;
			//水平布局
			if (this._orientation == Constants.HORIZONTAL) {
				if (_horizontalAlign == Constants.LEFT) {
					tmp = _paddingLeft;
					for (var i:int = 0; i < _numComponent; i += 1) {
						c = _componentList[i];
						c.x = tmp;
						tmp += c.width + _gap;
					}
				}else if (_horizontalAlign == Constants.CENTER) {
					//算出所有子对象的宽度之和
					for (i = 0; i < _numComponent; i += 1) {
						tmp += _componentList[i].width;
					}
					//再加上子对象之间的间距,就是所有子对象所需要的占据的宽度值
					tmp += (_numComponent - 1) * _gap;
					//算出第一个子对象所在的横坐标
					tmp = (this._actualWidth - tmp) >> 1;
					//遍历所有子对象，赋值正确的横坐标
					for (i = 0; i < _numComponent; i += 1) {
						c = _componentList[i];
						c.x = tmp;
						tmp += c.width + _gap;
					}
				}else {
					tmp = this._actualWidth - _paddingRight;
					i = _numComponent;
					while (--i > -1) {
						c = _componentList[i];
						c.x = tmp - c.width;
						tmp -= c.width + _gap;
					}
				}
				
				if (_verticalAlign == Constants.TOP) {
					tmp = _paddingTop;
					for (i = 0; i < _numComponent; i += 1) {
						_componentList[i].y = tmp;
					}
				}else if (_verticalAlign == Constants.MIDDLE) {
					for (i = 0; i < _numComponent; i += 1) {
						c = _componentList[i];
						c.y = (_actualHeight - c.height) >> 1;
					}
				}else {
					tmp = _paddingBottom;
					for (i = 0; i < _numComponent; i += 1) {
						c = _componentList[i];
						c.y = _actualHeight - tmp - c.height;
					}
				}
			}else {
				//垂直布局
				if (_horizontalAlign == Constants.LEFT) {
					tmp = _paddingLeft;
					for (i = 0; i < _numComponent; i += 1) {
						_componentList[i].x = tmp;
					}
				}else if (_horizontalAlign == Constants.CENTER) {
					for (i = 0; i < _numComponent; i++) {
						c = _componentList[i];
						c.x = (_actualWidth - c.width) >> 1;
					}
				}else {
					tmp = _paddingRight;
					for (i = 0; i < _numComponent; i += 1) {
						c = _componentList[i];
						c.x = _actualWidth - c.width - tmp;
					}
				}
				
				if (_verticalAlign == Constants.TOP) {
					tmp = _paddingTop;
					for (i = 0; i < _numComponent; i += 1) {
						c = _componentList[i];
						c.y = tmp;
						tmp += c.height + _gap;
					}
				}else if (_verticalAlign == Constants.MIDDLE) {
					for (i = 0; i < _numComponent; i++) {
						tmp += _componentList[i].height;
					}
					tmp += (_numComponent - 1) * _gap;
					tmp = (this._actualHeight - tmp) >> 1;
					for (i = 0; i < _numComponent; i++) {
						c = _componentList[i];
						c.y = tmp;
						tmp += c.height + _gap;
					}
				}else {
					tmp = this._actualHeight - _paddingBottom;
					i = _numComponent;
					while (--i > -1) {
						c = _componentList[i];
						c.y = tmp = c.height;
						tmp -= c.height + _gap;
					}
				}
			}
		}
		
		/**
		 * @inheritDoc
		 * @return
		 */
		override public function clone():Component {
			const group:JGroup = new JGroup(this.x, this.y, this._gap, this._orientation);
			group.paddingLeft = this._paddingLeft;
			group.paddingTop = this._paddingTop;
			group.paddingRight = this._paddingRight;
			group.paddingBottom = this._paddingBottom;
			group.verticalAlign = this._verticalAlign;
			group.horizontalAlign = this._horizontalAlign;
			return group;
		}
		
		/**
		 * @inheritDoc
		 * @return
		 */
		override public function toXML():XML {
			const xml:XML = super.toXML();
			xml.@gap = this._gap;
			if (_orientation != Constants.HORIZONTAL) xml.@orientation = this._orientation;
			if (_paddingLeft != 0) xml.@paddingLeft = this._paddingLeft;
			if (_paddingRight != 0) xml.@paddingRight = this._paddingRight;
			if (_paddingTOp != 0) xml.@paddingTop = this._paddingTop;
			if (_paddingBottom != 0) xml.@paddingBottom = this._paddingBottom;
			if (_horizontalAlign != Constants.LEFT) xml.horizontalAlign = this._horizontalAlign;
			if (_verticalAlign != Constants.MIDDLE) xml.verticalAlign = this._verticalAlign;
			return xml;
		}
		
		public function get orientation():int {
			return _orientation;
		}
		
		public function set orientation(value:int):void {
			if (_orientation != value) {
				_orientation = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function get gap():int {
			return _gap;
		}
		
		public function set gap(value:int):void {
			if (_gap != value) {
				_gap = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function get verticalAlign():int {
			return _verticalAlign;
		}
		
		public function set verticalAlign(value:int):void {
			if (_verticalAlign != value) {
				_verticalAlign = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function get horizontalAlign():int {
			return _horizontalAlign;
		}
		
		public function set horizontalAlign(value:int):void {
			if (_horizontalAlign != value) {
				_horizontalAlign = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function get paddingLeft():int {
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:int):void {
			if (_paddingLeft != value) {
				_paddingLeft = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function get paddingTop():int {
			return _paddingTop;
		}
		
		public function set paddingTop(value:int):void {
			if (_paddingTop != value) {
				_paddingTop = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function get paddingRight():int {
			return _paddingRight;
		}
		
		public function set paddingRight(value:int):void {
			if (_paddingRight != value) {
				_paddingRight = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function get paddingBottom():int {
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:int):void {
			if (_paddingBottom != value) {
				_paddingBottom = value;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
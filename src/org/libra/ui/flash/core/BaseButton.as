package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.libra.log4a.Logger;
	import org.libra.ui.flash.core.state.BaseButtonState;
	import org.libra.ui.flash.core.state.IButtonState;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.BtnSkin;
	import org.libra.ui.flash.theme.Filter;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * 按钮父类
	 * </p>
	 *
	 * @class BaseButton
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseButton extends BaseText {
		
		/**
		 * 常量
		 * 按钮正常状态
		 * @private
		 */
		protected static const NORMAL:int = 0;
		
		/**
		 * 常量
		 * 按钮鼠标移入状态
		 * @private
		 */
		protected static const MOUSE_OVER:int = 1;
		
		/**
		 * 常量
		 * 按钮按下状态
		 * @private
		 */
		protected static const MOUSE_DOWN:int = 2;
		
		/**
		 * 按钮当前状态
		 * @private
		 */
		protected var _curState:int;
		
		/**
		 * 控制按钮皮肤
		 * @private
		 */
		protected var _state:IButtonState;
		
		/**
		 * 按钮文本相对按钮的相对横坐标
		 * @private
		 */
		protected var _textX:int;
		
		/**
		 * 按钮文本相对按钮的相对纵坐标
		 * @private
		 */
		protected var _textY:int;
		
		protected var _skin:BtnSkin;
		
		/**
		 * 构造函数
		 * @param   skin 按钮主题
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	text 按钮文本
		 */
		public function BaseButton(x:int = 0, y:int = 0, skin:BtnSkin = null, text:String = null, font:JFont = null, filters:Array = null) { 
			super(x, y, text, font ? font : JFont.FONT_BTN, filters ? filters : Filter.BLACK);
			_skin = skin;
			_curState = NORMAL;
			setSize(skin.width, skin.height);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 按钮点击
		 */
		public function doClick():void {
			dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		override protected function init():void {
			super.init();
			this.initState();
		}
		
		override public function toXML():XML {
			const xml:XML = super.toXML();
			xml.@skinStr = this._skin.width + '&' + this._skin.height + '&' + this._skin.skin;
			return xml;
		}
		
		override public function clone():Component {
			return new BaseButton(this.x, this.y, this._skin, this.text, _font, _filters);
		}
		
		/**
		 * UI编辑器导出的皮肤配置进行赋值
		 */
		public function set skinStr(val:String):void {
			const ary:Array = val.split('&');
			if (ary.length == 3) {
				this.skin = new BtnSkin(ary[0], ary[1], ary[2]);
			}else {
				this.skin = UIManager.instance.skin.btnSkin;
				Logger.error('按钮的皮肤配置格式有误:' + ary);
			}
		}
		
		public function set skin(value:BtnSkin):void {
			_skin = value;
			this.invalidate(InvalidationFlag.STYLE);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 初始化控制按钮皮肤的实例
		 * 不同控制逻辑的按钮需要重写这个方法
		 * @private
		 */
		protected function initState():void {
			this._state = new BaseButtonState(_loader);
			_state.setSize(_actualWidth, _actualHeight);
			this._state.skin = _skin.skin;
			addChildAt(this._state.displayObject, 0);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function initTextField(text:String = ''):void {
			_textField = new TextField();
			_textField.selectable = _textField.tabEnabled = _textField.mouseWheelEnabled = _textField.mouseEnabled = _textField.doubleClickEnabled = false;
			_textField.multiline = false;
			setFont(_font);
			textFilter = _filters;
			this.textAlign = 'center';
			this.text = text;
			this.addChild(_textField);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			this._state.setSize(_actualWidth, _actualHeight);
			/*//保证按钮中的文本在垂直方向上永远居中
			//setTextLocation(_textX, (_actualHeight - _textField.textHeight) >> 1);
			setTextLocation(_textX, (_actualHeight - 16) >> 1);*/
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshState():void {
			if (this._curState == MOUSE_OVER) {
				this._state.toMouseOver();
				this._textField.x = _textX;
				this._textField.y = _textY;
			}else if (this._curState == MOUSE_DOWN) {
				this._state.toMouseDown();
				this._textField.x = _textX + 1;
				this._textField.y = _textY + 1;
			}else {
				this._state.toNormal();
				this._textField.x = _textX;
				this._textField.y = _textY;
			}
		}
		
		override protected function refreshText():void {
			super.refreshText();
			//保证按钮中的文本在垂直方向上永远居中
			setTextLocation(_textX, (_actualHeight - _textField.textHeight) >> 1);
		}
		
		override protected function refreshStyle():void {
			setSize(_skin.width, _skin.height);
			this._state.skin = _skin.skin;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setTextLocation(x:int, y:int):void {
			super.setTextLocation(x, y);
			this._textX = x;
			this._textY = y;
		}
		
		/**
		 * 设置当前按钮的状态
		 * @private
		 * @param	state
		 */
		protected function set curState(state:int):void {
			if (_curState != state) {
				this._curState = state;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 鼠标按下和抬起事件
		 * @private
		 * @param	e
		 */
		private function onMouseUpAndDown(e:MouseEvent):void {
			if (enabled) {
				curState = e.type == MouseEvent.MOUSE_DOWN ? MOUSE_DOWN : MOUSE_OVER;
			}
		}
		
		/**
		 * 鼠标移进和移出事件
		 * @private
		 * @param	e
		 */
		private function onRollOverAndOut(e:MouseEvent):void {
			if (enabled) {
				curState = e.type == MouseEvent.ROLL_OVER ? MOUSE_OVER : NORMAL;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOverAndOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOverAndOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseUpAndDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUpAndDown);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.ROLL_OUT, onRollOverAndOut);
			this.removeEventListener(MouseEvent.ROLL_OVER, onRollOverAndOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseUpAndDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpAndDown);
		}
	}

}
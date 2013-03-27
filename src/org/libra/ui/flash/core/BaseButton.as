package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.libra.ui.flash.core.state.BaseButtonState;
	import org.libra.ui.flash.core.state.IButtonState;
	import org.libra.ui.flash.theme.DefaultBtnTheme;
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
		protected var curState:int;
		
		/**
		 * 控制按钮皮肤
		 * @private
		 */
		protected var state:IButtonState;
		
		/**
		 * 按钮文本相对按钮的相对横坐标
		 * @private
		 */
		protected var textX:int;
		
		/**
		 * 按钮文本相对按钮的相对纵坐标
		 * @private
		 */
		protected var textY:int;
		
		/**
		 * 构造函数
		 * @param   theme 按钮主题
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	text 按钮文本
		 */
		public function BaseButton(theme:DefaultBtnTheme, x:int = 0, y:int = 0, text:String = '') { 
			super(theme, x, y, text);
			curState = NORMAL;
			this.initState();
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
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 初始化控制按钮皮肤的实例
		 * 不同控制逻辑的按钮需要重写这个方法
		 * @private
		 */
		protected function initState():void {
			this.state = new BaseButtonState();
			this.state.setResName((theme as DefaultBtnTheme).resName);
			addChildAt(this.state.getDisplayObject(), 0);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function initTextField(text:String = ''):void {
			textField = new TextField();
			textField.selectable = textField.tabEnabled = textField.mouseWheelEnabled = textField.mouseEnabled = textField.doubleClickEnabled = false;
			textField.multiline = false;
			setFont(theme.font);
			textField.filters = theme.filter;
			this.textAlign = 'center';
			this.text = text;
			this.addChild(textField);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			this.state.setSize(actualWidth, actualHeight);
			//保证按钮中的文本在垂直方向上永远居中
			setTextLocation(textX, (actualHeight - textField.textHeight) >> 1);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshState():void {
			if (this.curState == MOUSE_OVER) {
				this.state.toMouseOver();
				this.textField.x = textX;
				this.textField.y = textY;
			}else if (this.curState == MOUSE_DOWN) {
				this.state.toMouseDown();
				this.textField.x = textX + 1;
				this.textField.y = textY + 1;
			}else {
				this.state.toNormal();
				this.textField.x = textX;
				this.textField.y = textY;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setTextLocation(x:int, y:int):void {
			super.setTextLocation(x, y);
			this.textX = x;
			this.textY = y;
		}
		
		/**
		 * 设置当前按钮的状态
		 * @private
		 * @param	state
		 */
		protected function setCurState(state:int):void {
			if (curState != state) {
				this.curState = state;
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
				setCurState(e.type == MouseEvent.MOUSE_DOWN ? MOUSE_DOWN : MOUSE_OVER);
			}
		}
		
		/**
		 * 鼠标移进和移出事件
		 * @private
		 * @param	e
		 */
		private function onRollOverAndOut(e:MouseEvent):void {
			if (enabled) {
				setCurState(e.type == MouseEvent.ROLL_OVER ? MOUSE_OVER : NORMAL);
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
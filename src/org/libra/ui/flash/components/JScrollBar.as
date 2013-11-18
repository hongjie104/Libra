package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * //要滚动的对象的高度
	 *	var contentHeight:Number = 50 * 20;//_items.length * _listItemHeight;
	 *	//可见范围的高度
	 *	scrollBar.height = 200;
	 *	//可见范围高度除以要滚动的对象高度，势必是小于1的
	 *	scrollBar.setThumbPercent(scrollBar.height / contentHeight); 
	 *	//可见范围高度除以滚动对象中每一行的高度，得到可见范围内的行数
	 *	var pageSize:Number = MathUtil.floor(scrollBar.height / 20);
	 *	scrollBar.setPageSize(pageSize);
	 *	//item的个数减去pageSize，得到不可见范围内的行数，既需要滚动的数量
	 *	scrollBar.setMax(Math.max(0, 50 - pageSize));
	 * 
	 * @class JScrollBar
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JScrollBar extends Component {
		
		private const DELAY_TIME:int = 500;
		
		private const REPEAT_TIME:int = 100; 
		
		/**
		 * 是否自动隐藏
		 */
		protected var _autoHide:Boolean;
		
		/**
		 * 向上的按钮
		 */
		protected var _upBtn:JButton;
		
		/**
		 * 向下的按钮
		 */
		protected var _downBtn:JButton;
		
		/**
		 * 滑动条，不包含上下两个按钮的
		 */
		protected var _scrollSlider:JScrollSlider;
		
		/**
		 * 滚动条的方向，水平还是垂直
		 */
		protected var _orientation:int;
		
		/**
		 * 滑动条滑动了一个单位时，滚动区域中滚动多少个单位
		 * 默认是1
		 */
		protected var _lineSize:int;
		
		protected var _delayTimer:Timer;
		
		protected var _repeatTimer:Timer;
		
		/**
		 * 上按钮还是下按钮
		 */
		protected var _direction:int;
		
		protected var _shouldRepeat:Boolean;
		
		public function JScrollBar(orientation:int = 1, x:int = 0, y:int = 0) { 
			super(x, y);
			this._orientation = orientation;
			_shouldRepeat = _autoHide = false;
			_lineSize = 1;
			_orientation == Constants.HORIZONTAL ? setSize(132, 16) : setSize(16, 132);
			
			_delayTimer = new Timer(DELAY_TIME, 1);
			_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayComplete);
			_repeatTimer = new Timer(REPEAT_TIME);
			_repeatTimer.addEventListener(TimerEvent.TIMER, onRepeat);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSliderParams(min:Number, max:Number, value:Number):void {
			this._scrollSlider.setSliderParams(min, max, value);
		}
		
		public function set thumbPercent(value:Number):void {
			this._scrollSlider.thumbPercent = value;
			visible = _autoHide ? _scrollSlider.thumbPercent < 1.0 : true;
		}
		
		public function set autoHide(value:Boolean):void {
            _autoHide = value;
            invalidate(InvalidationFlag.STATE);
        }
		
		public function set value(v:Number):void {
			_scrollSlider.value = v;
		}
		
		public function get value():Number {
			return _scrollSlider.value;
		}
		
		public function set min(v:Number):void {
			_scrollSlider.min = v;
		}
		
		public function get min():Number {
			return _scrollSlider.min;
		}
		
		public function set max(v:Number):void {
			this._scrollSlider.max = v;
		}
		
		public function get max():Number {
			return this._scrollSlider.max
		}
		
		/**
		 * Sets the amount the value will change when up or down buttons are pressed.
		 */
		public function set lineSize(value:int):void {
			_lineSize = value;
		}
		
		/**
		 * Sets the amount the value will change when the back is clicked.
		 */
		public function set pageSize(value:int):void {
			_scrollSlider.pageSize = value;
		}
		
		public function changeValue(add:Number):void {
			this._scrollSlider.changeValue(add);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone():Component {
			return new JScrollBar(_orientation, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function init():void {
			super.init();
			
			//滑动条
			this._scrollSlider = new JScrollSlider(this._orientation, 0, 16);
			this.addChild(_scrollSlider);
			
			//上下两个按钮
			_upBtn = new JButton(0, 0, _orientation == Constants.HORIZONTAL ? UIManager.instance.skin.hScrollRightBtnSkin : UIManager.instance.skin.vScrollUpBtnSkin);
			this.addChild(_upBtn);
			_downBtn = new JButton(0, 0, _orientation == Constants.HORIZONTAL ? UIManager.instance.skin.hScrollLefttBtnSkin : UIManager.instance.skin.vScrollDownBtnSkin);
			this.addChild(_downBtn);
		}
		
		override protected function resize():void {
			if(_orientation == Constants.VERTICAL) {
				_scrollSlider.x = 0;
				_scrollSlider.y = _upBtn.height;
				_scrollSlider.width = _actualWidth;
				_scrollSlider.height = _actualHeight - (_upBtn.height << 1);
				_downBtn.x = 0;
				_downBtn.y = _actualHeight - _downBtn.height;
			} else {
				_scrollSlider.x = _downBtn.width;
				_scrollSlider.y = 0;
				_scrollSlider.width = _actualWidth - (_downBtn.width << 1);
				_scrollSlider.height = _actualHeight;
				_downBtn.x = _actualWidth - _downBtn.width;
				_downBtn.y = 0;
			}
			refreshState();
		}
		
		override protected function refreshState():void {
			visible = _autoHide ? _scrollSlider.thumbPercent < 1.0 : true;
		}
		
		protected function goUp():void {
			_scrollSlider.changeValue(0 - _lineSize);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function goDown():void {
			this._scrollSlider.changeValue(_lineSize);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this._scrollSlider.addEventListener(Event.CHANGE, onChange);
			this._upBtn.addEventListener(MouseEvent.MOUSE_DOWN, onUpBtnDown);
			this._downBtn.addEventListener(MouseEvent.MOUSE_DOWN, onDownBtnDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this._scrollSlider.removeEventListener(Event.CHANGE, onChange);
			this._upBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onUpBtnDown);
			this._downBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onDownBtnDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onUpBtnDown(event:MouseEvent):void {
			goUp();
			_shouldRepeat = true;
			_direction = Constants.UP;
			_delayTimer.start();
		}
		
		protected function onDownBtnDown(event:MouseEvent):void {
			goDown();
			_shouldRepeat = true;
			_direction = Constants.DOWN;
			_delayTimer.start();
		}
		
		protected function onMouseUp(event:MouseEvent):void{
			_delayTimer.stop();
			_repeatTimer.stop();
			_shouldRepeat = false;
		}
		
		protected function onChange(event:Event):void {
			dispatchEvent(event);
		}
		
		protected function onDelayComplete(event:TimerEvent):void {
			if(_shouldRepeat) {
				_repeatTimer.start();
			}
		}
		
		protected function onRepeat(event:TimerEvent):void {
			_direction == Constants.UP ? goUp() : goDown();
		}
		
	}

}
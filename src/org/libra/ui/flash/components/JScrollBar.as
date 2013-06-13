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
		protected var $autoHide:Boolean;
		
		/**
		 * 向上的按钮
		 */
		protected var $upBtn:JButton;
		
		/**
		 * 向下的按钮
		 */
		protected var $downBtn:JButton;
		
		/**
		 * 滑动条，不包含上下两个按钮的
		 */
		protected var $scrollSlider:JScrollSlider;
		
		/**
		 * 滚动条的方向，水平还是垂直
		 */
		protected var $orientation:int;
		
		/**
		 * 滑动条滑动了一个单位时，滚动区域中滚动多少个单位
		 * 默认是1
		 */
		protected var $lineSize:int;
		
		protected var $delayTimer:Timer;
		
		protected var $repeatTimer:Timer;
		
		/**
		 * 上按钮还是下按钮
		 */
		protected var $direction:int;
		
		protected var $shouldRepeat:Boolean;
		
		public function JScrollBar(orientation:int = 1, x:int = 0, y:int = 0) { 
			super(x, y);
			this.$orientation = orientation;
			$shouldRepeat = $autoHide = false;
			$lineSize = 1;
			$orientation == Constants.HORIZONTAL ? setSize(132, 16) : setSize(16, 132);
			
			$delayTimer = new Timer(DELAY_TIME, 1);
			$delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayComplete);
			$repeatTimer = new Timer(REPEAT_TIME);
			$repeatTimer.addEventListener(TimerEvent.TIMER, onRepeat);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSliderParams(min:Number, max:Number, value:Number):void {
			this.$scrollSlider.setSliderParams(min, max, value);
		}
		
		public function set thumbPercent(value:Number):void {
			this.$scrollSlider.thumbPercent = value;
			visible = $autoHide ? $scrollSlider.thumbPercent < 1.0 : true;
		}
		
		public function set autoHide(value:Boolean):void {
            $autoHide = value;
            invalidate(InvalidationFlag.STATE);
        }
		
		public function set value(v:Number):void {
			$scrollSlider.value = v;
		}
		
		public function get value():Number {
			return $scrollSlider.value;
		}
		
		public function set min(v:Number):void {
			$scrollSlider.min = v;
		}
		
		public function get min():Number {
			return $scrollSlider.min;
		}
		
		public function set max(v:Number):void {
			this.$scrollSlider.max = v;
		}
		
		public function get max():Number {
			return this.$scrollSlider.max
		}
		
		/**
		 * Sets the amount the value will change when up or down buttons are pressed.
		 */
		public function set lineSize(value:int):void {
			$lineSize = value;
		}
		
		/**
		 * Sets the amount the value will change when the back is clicked.
		 */
		public function set pageSize(value:int):void {
			$scrollSlider.pageSize = value;
		}
		
		public function changeValue(add:Number):void {
			this.$scrollSlider.changeValue(add);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function init():void {
			super.init();
			
			//滑动条
			this.$scrollSlider = new JScrollSlider(this.$orientation, 0, 16);
			this.addChild($scrollSlider);
			
			//上下两个按钮
			$upBtn = new JButton($orientation == Constants.HORIZONTAL ? UIManager.getInstance().theme.hScrollRightBtnTheme : UIManager.getInstance().theme.vScrollUpBtnTheme);
			this.addChild($upBtn);
			$downBtn = new JButton($orientation == Constants.HORIZONTAL ? UIManager.getInstance().theme.hScrollLefttBtnTheme : UIManager.getInstance().theme.vScrollDownBtnTheme);
			this.addChild($downBtn);
		}
		
		override protected function resize():void {
			if($orientation == Constants.VERTICAL) {
				$scrollSlider.x = 0;
				$scrollSlider.y = $upBtn.height;
				$scrollSlider.width = $actualWidth;
				$scrollSlider.height = $actualHeight - ($upBtn.height << 1);
				$downBtn.x = 0;
				$downBtn.y = $actualHeight - $downBtn.height;
			} else {
				$scrollSlider.x = $downBtn.width;
				$scrollSlider.y = 0;
				$scrollSlider.width = $actualWidth - ($downBtn.width << 1);
				$scrollSlider.height = $actualHeight;
				$downBtn.x = $actualWidth - $downBtn.width;
				$downBtn.y = 0;
			}
			refreshState();
		}
		
		override protected function refreshState():void {
			visible = $autoHide ? $scrollSlider.thumbPercent < 1.0 : true;
		}
		
		protected function goUp():void {
			$scrollSlider.changeValue(0 - $lineSize);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function goDown():void {
			this.$scrollSlider.changeValue($lineSize);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.$scrollSlider.addEventListener(Event.CHANGE, onChange);
			this.$upBtn.addEventListener(MouseEvent.MOUSE_DOWN, onUpBtnDown);
			this.$downBtn.addEventListener(MouseEvent.MOUSE_DOWN, onDownBtnDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.$scrollSlider.removeEventListener(Event.CHANGE, onChange);
			this.$upBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onUpBtnDown);
			this.$downBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onDownBtnDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onUpBtnDown(event:MouseEvent):void {
			goUp();
			$shouldRepeat = true;
			$direction = Constants.UP;
			$delayTimer.start();
		}
		
		protected function onDownBtnDown(event:MouseEvent):void {
			goDown();
			$shouldRepeat = true;
			$direction = Constants.DOWN;
			$delayTimer.start();
		}
		
		protected function onMouseUp(event:MouseEvent):void{
			$delayTimer.stop();
			$repeatTimer.stop();
			$shouldRepeat = false;
		}
		
		protected function onChange(event:Event):void {
			dispatchEvent(event);
		}
		
		protected function onDelayComplete(event:TimerEvent):void {
			if($shouldRepeat) {
				$repeatTimer.start();
			}
		}
		
		protected function onRepeat(event:TimerEvent):void {
			$direction == Constants.UP ? goUp() : goDown();
		}
		
	}

}
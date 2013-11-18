package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.MathUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JPageCounter
	 * @author Eddie
	 * @qq 32968210
	 * @date 03/31/2013
	 * @version 1.0
	 * @see
	 */
	public class JPageCounter extends Component {
		
		protected var _maxVal:int;
		
		protected var _minVal:int;
		
		protected var _val:int;
		
		protected var _prevBtn:JButton;
		
		protected var _nextBtn:JButton;
		
		protected var _counterLabel:JLabel;
		
		public function JPageCounter(maxVal:int = 100, minVal:int = 0, x:int = 0, y:int = 0) { 
			super(x, y);
			setSize(80, 20);
			this.maxVal = maxVal;
			this.minVal = minVal;
			value = minVal;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			
			this._prevBtn = new JButton(0, 0, UIManager.instance.skin.hScrollLefttBtnSkin);
			this._nextBtn = new JButton(0, 0, UIManager.instance.skin.hScrollRightBtnSkin);
			this._counterLabel = new JLabel();
			_counterLabel.textAlign = 'center';
			this.addChild(_prevBtn);
			this.addChild(_nextBtn);
			this.addChild(_counterLabel);
		}
		
		public function set maxVal(val:int):void {
			if (_maxVal != val) {
				_maxVal = MathUtil.max(val, _minVal);
				_val = MathUtil.min(_val, _maxVal);
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		public function get maxVal():int {
			return _maxVal;
		}
		
		public function set minVal(val:int):void {
			if (_minVal != val) {
				_minVal = MathUtil.min(val, _maxVal);
				_val = MathUtil.max(_val, _minVal);
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		public function get minVal():int {
			return _minVal;
		}
		
		public function set value(val:int):void {
			if (_val != val) {
				_val = MathUtil.min(_val, _maxVal);
				_val = MathUtil.max(_val, _minVal);
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		public function get value():int {
			return _val;
		}
		
		override public function clone():Component {
			return new JPageCounter(_maxVal, _minVal, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			this._nextBtn.x = _actualWidth - _nextBtn.width;
			this._counterLabel.width = _actualWidth - _prevBtn.width - _nextBtn.width;
			this._counterLabel.x = _prevBtn.width;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshData():void {
			this._counterLabel.text = _val + '/' + _maxVal;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			_prevBtn.addEventListener(MouseEvent.CLICK, onPrev);
			_nextBtn.addEventListener(MouseEvent.CLICK, onNext);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			_prevBtn.removeEventListener(MouseEvent.CLICK, onPrev);
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNext);
		}
		
		private function onPrev(e:MouseEvent):void {
			if (this._val > _minVal) {
				this._val--;
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		private function onNext(e:MouseEvent):void {
			if (this._val < _maxVal) {
				this._val += 1;
				invalidate(InvalidationFlag.DATA);
			}
		}
	}

}
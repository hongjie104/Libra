package org.libra.ui.flash.components {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.theme.Skin;
	import org.libra.utils.displayObject.GraphicsUtil;
	import org.libra.utils.MathUtil;
	
	/**
	 * <p>
	 * 滑动器
	 * </p>
	 *
	 * @class JSlider
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public class JSlider extends Component {
		
		protected var _block:Sprite;
		
		protected var _backClick:Boolean;
		
		protected var _value:Number = 0;
		
		protected var _max:Number = 100;
		
		protected var _min:Number = 0;
		
		protected var _orientation:int;
		
		public function JSlider(orientation:int = 1, x:int = 0, y:int = 0) { 
			super(x, y);
			this._orientation = orientation;
			_backClick = true;
			_orientation == Constants.HORIZONTAL ? setSize(100, 18) : setSize(18, 100);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSliderParams(min:Number, max:Number, value:Number):void { 
			this._min = min;
			this._max = max;
			this._value = value;
			this.correctValue();
			positionBlock();
		}
		
		public function set backClick(b:Boolean):void {
			_backClick = b;
		}
		
		public function set value(v:Number):void {
			if (this._value != v) {
				_value = v;
				correctValue();
				positionBlock();
			}
		}
		
		public function get value():Number {
			return _value;
		}
		
		public function set max(m:Number):void {
			_max = m;
			correctValue();
			positionBlock();
		}
		
		public function get max():Number{
			return _max;
		}
		
		public function set min(m:Number):void {
			_min = m;
			correctValue();
			positionBlock();
		}
		
		public function get min():Number {
			return _min;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void {
			super.dispose();
			if (this._background.hasEventListener(MouseEvent.MOUSE_DOWN))
				this._background.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClicked);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			drawBack();
			drawBlock();
		}
		
		protected function drawBack():void {
			this.background = new Sprite();
		}
		
		protected function drawBlock():void {
			this._block = new Sprite();
			this._block.buttonMode = true;
			this.addChild(_block);
		}
		
		override protected function resize():void {
			renderBack();
			renderBlock();
		}
		
		protected function renderBack():void {
			GraphicsUtil.drawRect((_background as Sprite).graphics, 0, 0, _actualWidth, _actualHeight, Skin.BACKGROUND);
		}
		
		protected function renderBlock():void {
			if (this._orientation == Constants.HORIZONTAL)
				GraphicsUtil.drawRect(_block.graphics, 1, 1, _actualHeight - 2, _actualHeight - 2, Skin.BUTTON_FACE);
			else 
				GraphicsUtil.drawRect(_block.graphics, 1, 1, _actualWidth - 2, _actualWidth - 2, Skin.BUTTON_FACE);
			positionBlock();
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this._block.addEventListener(MouseEvent.MOUSE_DOWN, onDragBlock);
			if (_backClick) this._background.addEventListener(MouseEvent.MOUSE_DOWN, onBackClicked);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this._block.removeEventListener(MouseEvent.MOUSE_DOWN, onDragBlock);
			if (_backClick) this._background.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClicked);
		}
		
		/**
		 * Adjusts position of handle when value, maximum or minimum have changed.
		 * TODO: Should also be called when slider is resized.
		 */
		protected function positionBlock():void {
			var range:Number;
			if(_orientation == Constants.HORIZONTAL) {
				range = _actualWidth - _actualHeight;
				_block.x = (_value - _min) / (_max - _min) * range;
			} else {
				range = _actualHeight - _actualWidth;
				_block.y = _actualHeight - _actualWidth - (_value - _min) / (_max - _min) * range;
			}
		}
		
		/**
		 * 修正值
		 */
		protected function correctValue():void {
			if(_max > _min) {
				_value = MathUtil.min(_value, _max);
				_value = MathUtil.max(_value, _min);
			} else {
				_value = MathUtil.max(_value, _max);
				_value = MathUtil.min(_value, _min);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		protected function onDragBlock(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			if(_orientation == Constants.HORIZONTAL) {
				_block.startDrag(false, new Rectangle(0, 0, _actualWidth - _actualHeight, 0));
				//_block.startDrag(false, new Rectangle(0, 0, _actualWidth - _block.width, 0));
			} else {
				_block.startDrag(false, new Rectangle(0, 0, 0, _actualHeight - _actualWidth));
				//_block.startDrag(false, new Rectangle(0, 0, 0, _actualHeight - _block.height));
			}
		}
		
		/**
		 * Internal mouseUp handler. Stops dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrop(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			_block.stopDrag();
		}
		
		protected function onSlide(event:MouseEvent):void {
			var oldValue:Number = _value;
			if(_orientation == Constants.HORIZONTAL) {
				_value = _block.x / (_actualWidth - _actualHeight) * (_max - _min) + _min;
			} else {
				_value = (_actualHeight - _actualWidth - _block.y) / (height - _actualWidth) * (_max - _min) + _min;
			}
			if(_value != oldValue) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		protected function onBackClicked(e:MouseEvent):void {
			if(_orientation == Constants.HORIZONTAL) {
				_block.x = mouseX - _actualHeight / 2;
				_block.x = MathUtil.max(_block.x, 0);
				_block.x = MathUtil.min(_block.x, _actualWidth - _actualHeight);
				_value = _block.x / (width - _actualHeight) * (_max - _min) + _min;
			} else {
				_block.y = mouseY - _actualWidth / 2;
				_block.y = MathUtil.max(_block.y, 0);
				_block.y = MathUtil.min(_block.y, _actualHeight - _actualWidth);
				_value = (_actualHeight - _actualWidth - _block.y) / (height - _actualWidth) * (_min - _min) + _min;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}
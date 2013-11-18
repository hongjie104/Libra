package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.Constants;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.displayObject.GraphicsUtil;
	import org.libra.utils.MathUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JScrollSlider
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JScrollSlider extends JSlider {
		
		/**
		 * 可见范围高度(宽度)除以要滚动的对象高度(宽度)
		 * 该值势必是不大于1的，如果等于1，说明不用滚动。
		 */
		protected var _thumbPercent:Number;
		
		/**
		 * 可见范围内的行数(列数)
		 * 一般通过可见范围高度除以滚动对象中每一行的高度得到该值
		 */
		protected var _pageSize:int;
		
		public function JScrollSlider(orientation:int = 1, x:int = 0, y:int = 0) { 
			super(orientation, x, y);
			_thumbPercent = 1.0;
			_pageSize = 1;
			orientation == Constants.HORIZONTAL ? setSize(100, 16) : setSize(16, 100);
			//this.setSliderParams(1, 1, 0);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set thumbPercent(value:Number):void {
			//if (this._thumbPercent != value) {
			_thumbPercent = MathUtil.min(value, 1.0);
			invalidate(InvalidationFlag.SIZE);
			//}
		}
		
		public function get thumbPercent():Number {
			return this._thumbPercent;
		}
		
		public function set pageSize(value:int):void {
			_pageSize = value;
		}
		
		public function changeValue(add:Number):void {
			this.value = this._value + add;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function drawBlock():void {
			if (_block) {
				this.removeChild(_block);
			}
			this._block = new JScrollBlock(this._orientation);
			this._block.buttonMode = true;
			this.addChild(_block);
		}
		
		override protected function renderBlock():void {
			var size:Number;
			if(_orientation == Constants.HORIZONTAL) {
				size = MathUtil.max(_actualHeight, Math.round(_actualWidth * _thumbPercent));
				GraphicsUtil.drawRect(_block.graphics, 0, 0, size, _actualHeight, 0, 0);
				//GraphicsUtil.drawRect(_block.graphics, 1, 1, size - 2, _actualHeight - 2, Style.BUTTON_FACE, 1.0, false);
				(_block as JScrollBlock).setBounds(1, 1, size - 2, _actualHeight - 2);
			} else {
				size = MathUtil.max(_actualWidth, Math.round(_actualHeight * _thumbPercent));
				GraphicsUtil.drawRect(_block.graphics, 0, 0, _actualWidth  - 2, size, 0, 0);
				//GraphicsUtil.drawRect(_block.graphics, 1, 1, _actualWidth - 2, size - 2, Style.BUTTON_FACE, 1.0, false);
				(_block as JScrollBlock).setBounds(1, 1, _actualWidth - 2, size - 2);
			}
			
			positionBlock();
		}
		
		protected override function positionBlock():void {
			var range:Number;
			if(_orientation == Constants.HORIZONTAL) {
				range = _actualWidth - _block.width;
				_block.x = (value - min) / (max - min) * range;
			} else {
				range = _actualHeight - _block.height;
				_block.y = (value - min) / (max - min) * range;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		protected override function onDragBlock(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			_block.startDrag(false, _orientation == Constants.HORIZONTAL ? new Rectangle(0, 1, _actualWidth - _block.width, 0) : new Rectangle(1, 0, 0, _actualHeight - _block.height));
		}
		
		protected override function onSlide(event:MouseEvent):void {
			var oldValue:Number = value;
			if(_orientation == Constants.HORIZONTAL) {
				value = _actualWidth == _block.width ? min : _block.x / (_actualWidth - _block.width) * (max - min) + min;
			} else {
				value = _actualHeight == _block.height ? min : _block.y / (_actualHeight - _block.height) * (max - min) + min;
			}
			if(value != oldValue) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		protected override function onBackClicked(event:MouseEvent):void{
			if(_orientation == Constants.HORIZONTAL) {
				if(mouseX < _block.x) value = max > min ? value - _pageSize : value + _pageSize;
				else value = max > min ? value + _pageSize : value - _pageSize;
			} else {
				if(mouseY < _block.y) value = max > min ? value - _pageSize : value + _pageSize;
				else value = max > min ? value + _pageSize : value - _pageSize;
			}
			correctValue();
			positionBlock();
			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}
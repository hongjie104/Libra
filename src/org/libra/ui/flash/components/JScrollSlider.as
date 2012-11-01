package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.Constants;
	import org.libra.utils.GraphicsUtil;
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
		protected var thumbPercent:Number;
		
		/**
		 * 可见范围内的行数(列数)
		 * 一般通过可见范围高度除以滚动对象中每一行的高度得到该值
		 */
		protected var pageSize:int;
		
		public function JScrollSlider(orientation:int = 1, x:int = 0, y:int = 0) { 
			super(orientation, x, y);
			thumbPercent = 1.0;
			pageSize = 1;
			orientation == Constants.HORIZONTAL ? setSize(100, 16) : setSize(16, 100);
			//this.setSliderParams(1, 1, 0);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setThumbPercent(value:Number):void {
			//if (this.thumbPercent != value) {
			thumbPercent = MathUtil.min(value, 1.0);
			invalidate();
			//}
		}
		
		public function getThumbPercent():Number {
			return this.thumbPercent;
		}
		
		public function setPageSize(value:int):void {
			pageSize = value;
		}
		
		public function changeValue(add:Number):void {
			this.setValue(this.value + add);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function drawBlock():void {
			this.block = new JScrollBlock(this.orientation);
			this.block.buttonMode = true;
			this.addChild(block);
		}
		
		override protected function renderBlock():void {
			var size:Number;
			if(orientation == Constants.HORIZONTAL) {
				size = MathUtil.max($height, Math.round($width * thumbPercent));
				GraphicsUtil.drawRect(block.graphics, 0, 0, size, $height, 0, 0);
				//GraphicsUtil.drawRect(block.graphics, 1, 1, size - 2, $height - 2, Style.BUTTON_FACE, 1.0, false);
				(block as JScrollBlock).setBounds(1, 1, size - 2, $height - 2);
			} else {
				size = MathUtil.max($width, Math.round($height * thumbPercent));
				GraphicsUtil.drawRect(block.graphics, 0, 0, $width  - 2, size, 0, 0);
				//GraphicsUtil.drawRect(block.graphics, 1, 1, $width - 2, size - 2, Style.BUTTON_FACE, 1.0, false);
				(block as JScrollBlock).setBounds(1, 1, $width - 2, size - 2);
			}
			
			positionBlock();
		}
		
		protected override function positionBlock():void {
			var range:Number;
			if(orientation == Constants.HORIZONTAL) {
				range = $width - block.width;
				block.x = (value - min) / (max - min) * range;
			} else {
				range = $height - block.height;
				block.y = (value - min) / (max - min) * range;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		protected override function onDragBlock(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			if(orientation == Constants.HORIZONTAL) {
				block.startDrag(false, new Rectangle(0, 1, $width - block.width, 0));
			} else {
				block.startDrag(false, new Rectangle(1, 0, 0, $height - block.height));
			}
		}
		
		protected override function onSlide(event:MouseEvent):void {
			var oldValue:Number = value;
			if(orientation == Constants.HORIZONTAL) {
				value = $width == block.width ? min : block.x / ($width - block.width) * (max - min) + min;
			} else {
				value = $height == block.height ? min : block.y / ($height - block.height) * (max - min) + min;
			}
			if(value != oldValue) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		protected override function onBackClicked(event:MouseEvent):void{
			if(orientation == Constants.HORIZONTAL) {
				if(mouseX < block.x) value = max > min ? value - pageSize : value + pageSize;
				else value = max > min ? value + pageSize : value - pageSize;
			} else {
				if(mouseY < block.y) value = max > min ? value - pageSize : value + pageSize;
				else value = max > min ? value + pageSize : value - pageSize;
			}
			correctValue();
			positionBlock();
			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}
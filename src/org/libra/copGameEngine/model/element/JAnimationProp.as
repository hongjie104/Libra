package org.libra.copGameEngine.model.element {
	import flash.display.BitmapData;
	import flash.events.Event;
	import org.libra.bmpEngine.multi.RenderLayer;
	import org.libra.bmpEngine.multi.RenderMovieClip;
	import org.libra.copGameEngine.component.JMultiBitmapDataRender;
	import org.libra.copGameEngine.model.basic.JBitmapObject;
	import org.libra.tick.ITickable;
	import org.libra.tick.Tick;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JAnimationProp
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JAnimationProp extends JBitmapObject implements ITickable {
		
		protected var _tickabled:Boolean;
		
		protected var _renderLayer:RenderLayer;
		
		protected var _baseMovieClip:RenderMovieClip;
		
		protected var _multiBitmapDataRender:JMultiBitmapDataRender;
		
		/**
		 * 当前动作的帧索引
		 * @private
		 */
		protected var _curAnimationStep:int;
		
		/**
		 * 当前动作的总帧数
		 * @private
		 */
		protected var _totalAnimationStep:int;
		
		/**
		 * 当前动作停留的时间,单位毫秒
		 * @private
		 */
		protected var _animationTimer:int;
		
		public function JAnimationProp(width:int, height:int, bitmapDataRender:JMultiBitmapDataRender) {
			super(width, height, bitmapDataRender);
			
			_multiBitmapDataRender = bitmapDataRender;
			_renderLayer = new RenderLayer(width, height);
			_baseMovieClip = new RenderMovieClip(null);
			_renderLayer.addItem(_baseMovieClip);
			_multiBitmapDataRender.addLayer(_renderLayer);
			
			_tickabled = true;
			_sprite.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function get tickabled():Boolean {
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			_tickabled = value;
		}
		
		public function tick(interval:int):void {
			_baseMovieClip.tick(interval);
			_multiBitmapDataRender.tick(interval);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set bmdList(val:Vector.<BitmapData>):void {
			this._baseMovieClip.bmdList = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onAddToStage(e:Event):void {
			_sprite.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			_sprite.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			Tick.instance.addItem(this);
		}
		
		private function onRemoveFromStage(e:Event):void {
			_sprite.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			_sprite.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			Tick.instance.removeItem(this);
		}
		
	}

}
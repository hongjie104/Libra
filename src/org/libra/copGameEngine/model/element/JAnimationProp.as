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
		
		protected var $tickabled:Boolean;
		
		protected var $renderLayer:RenderLayer;
		
		protected var $baseMovieClip:RenderMovieClip;
		
		protected var $multiBitmapDataRender:JMultiBitmapDataRender;
		
		/**
		 * 当前动作的帧索引
		 * @private
		 */
		protected var $curAnimationStep:int;
		
		/**
		 * 当前动作的总帧数
		 * @private
		 */
		protected var $totalAnimationStep:int;
		
		/**
		 * 当前动作停留的时间,单位毫秒
		 * @private
		 */
		protected var $animationTimer:int;
		
		public function JAnimationProp(width:int, height:int, bitmapDataRender:JMultiBitmapDataRender) {
			super(width, height, bitmapDataRender);
			
			$multiBitmapDataRender = bitmapDataRender;
			$renderLayer = new RenderLayer(width, height);
			$baseMovieClip = new RenderMovieClip(null);
			$renderLayer.addItem($baseMovieClip);
			$multiBitmapDataRender.addLayer($renderLayer);
			
			$tickabled = true;
			$sprite.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function get tickabled():Boolean {
			return $tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			$tickabled = value;
		}
		
		public function tick(interval:int):void {
			$baseMovieClip.tick(interval);
			$multiBitmapDataRender.tick(interval);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set bmdList(val:Vector.<BitmapData>):void {
			this.$baseMovieClip.bmdList = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onAddToStage(e:Event):void {
			$sprite.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			$sprite.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			Tick.getInstance().addItem(this);
		}
		
		private function onRemoveFromStage(e:Event):void {
			$sprite.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			$sprite.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			Tick.getInstance().removeItem(this);
		}
		
	}

}
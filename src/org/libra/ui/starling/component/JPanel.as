package org.libra.ui.starling.component {
	import org.libra.starling.ui.core.Container;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JPanel
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class JPanel extends Container {
		
		protected var owner:Container;
		
		protected var showing:Boolean;
		
		protected var clickUp:Boolean;
		
		public function JPanel(owner:Container, width:int, height:int, x:int = 0, y:int = 0) {
			super(width, height, x, y);
			this.owner = owner;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function show():void {
			if (showing) return;
			this.owner.addChild(this);
			showing = true;
		}
		
		public function close():void {
			if (showing) {
				this.owner.removeChild(this);
				showing = false;
			}
		}
		
		public function showSwitch():void {
			showing ? close() : show();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if (e.target == this) {
				this.addEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void {
			if (!this.enabled) return;
			
			const touches:Vector.<Touch> = e.getTouches(this);
			if(!touches.length) return;
			
			for each(touch in touches) {
				if(touch.phase == TouchPhase.BEGAN) {
					owner.bringToTop(this);
					return;
				}
			}
		}
	}

}
package org.libra.game.objects {
	import flash.display.Bitmap;
	import flash.events.Event;
	import org.libra.displayObject.JSprite;
	import org.libra.tick.ITickable;
	import org.libra.tick.Tick;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ObjectTickable
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/13/2012
	 * @version 1.0
	 * @see
	 */
	public class ObjectTickable extends JSprite implements ITickable {
		
		protected var _tickabled:Boolean;
		
		protected var baseBitmap:Bitmap;
		
		public function ObjectTickable() {
			super();
			baseBitmap = new Bitmap();
			this.addChild(baseBitmap);
			_tickabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getBitmap():Bitmap {
			return this.baseBitmap;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			
		}
		
		public function get tickabled():Boolean {
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			_tickabled = value;
		}
		
		override public function dispose():void {
			super.dispose();
			onRemoveFromStage(null);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			Tick.instance.addItem(this);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			Tick.instance.removeItem(this);
		}
	}

}
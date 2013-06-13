package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.Container;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JCell
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public class JCell extends Container {
		
		protected var $selected:Boolean;
		
		protected var $border:Bitmap;
		
		protected var $borderBmd:BitmapData;
		
		public function JCell(x:int = 0, y:int = 0) { 
			super(x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			$border = new Bitmap();
			addChild($border);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			removeEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			removeEventListener(MouseEvent.ROLL_OUT, onRollHandler);
		}
		
		protected function onRollHandler(e:MouseEvent):void {
			$border.bitmapData = e.type == MouseEvent.ROLL_OVER ? $borderBmd : null;
		}
		
	}

}
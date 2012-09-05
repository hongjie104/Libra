package org.libra.ui.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.base.Container;
	import org.libra.ui.base.stateus.BaseListItemStatus;
	import org.libra.ui.base.stateus.interfaces.ISelectStatus;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JListItem
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JListItem extends Container {
		
		private var data:*;
		
		private var selected:Boolean;
		
		private var status:ISelectStatus;
		
		private var label:JLabel;
		
		public function JListItem(x:int = 0, y:int = 0) { 
			super(x, y);
			this.mouseChildren = this.mouseEnabled = true;
			initStatue();
			this.setSize(100, 20);
			selected = false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			this.status.setSize(w, h);
		}
		
		public function setSelected(val:Boolean):void {
			this.selected = val;
			this.status.setSelected(val);
		}
		
		public function isSelected():Boolean {
			return this.selected;
		}
		
		public function setData(data:*):void {
			this.data = data;
			invalidate();
		}
		
		public function getData():*{
			return this.data;
		}
		
		override public function toString():String {
			return 'JListItem';
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function initStatue():void {
			status = new BaseListItemStatus();
			this.addChild(status.getDisplayObject());
		}
		
		override protected function draw():void {
			super.draw();
			
			label = new JLabel();
			this.append(label);
		}
		
		override protected function render():void {
			super.render();
			if (label) {
				label.text = data;
				label.setSize($width, $height);
			}
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseRoll);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseRoll);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.ROLL_OVER, onMouseRoll);
			this.removeEventListener(MouseEvent.ROLL_OUT, onMouseRoll);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onMouseRoll(e:MouseEvent):void {
			e.type == MouseEvent.ROLL_OVER ? this.status.toMouseOver() : this.status.toNormal();
		}
	}

}
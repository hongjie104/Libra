package org.libra.ui.flash.components {
	import flash.events.Event;
	import org.libra.tick.ITimerable;
	import org.libra.tick.MultiTimer;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * 倒计时
	 * </p>
	 *
	 * @class JCountDown
	 * @author Eddie
	 * @qq 32968210
	 * @date 03/31/2013
	 * @version 1.0
	 * @see
	 */
	public class JCountDown extends JLabel implements ITimerable {
		
		protected var _hour:int;
		
		protected var _minute:int;
		
		protected var _second:int;
		
		protected var _prefixText:String;
		
		public function JCountDown(x:int = 0, y:int = 0, prefixText:String = '') { 
			super(x, y);
			this._prefixText = prefixText;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setLeftSecond(val:int):void {
			this._hour = val / 3600;
			this._minute = (val % 3600) / 60;
			this._second = val % 60;
			invalidate(InvalidationFlag.DATA);
			MultiTimer.instance.addItem(this);
		}
		
		/* INTERFACE org.libra.tick.ITimerable */
		
		public function doAction():void {
			if (--_second < 0) {
				this._second = 59;
				if (--_minute < 0) {
					this._minute = 59;
					if (--_hour < 0) {
						this._hour = this._minute = this._second = 0;
						MultiTimer.instance.removeItem(this);
						dispatchEvent(new Event(Event.COMPLETE));
					}
				}
			}
			invalidate(InvalidationFlag.DATA);
		}
		
		override public function clone():Component {
			return new JCountDown(x, y, _prefixText);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function refreshData():void {
			text = this._prefixText + toStr(_hour) + ':' + toStr(_minute) + ':' + toStr(_second);
			refreshText();
		}
		
		protected function toStr(val:int):String {
			return val < 10 ? '0' + val : val.toString();
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
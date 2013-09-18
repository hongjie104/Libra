package org.libra.ui.flash.components {
	import flash.events.Event;
	import org.libra.tick.ITimerable;
	import org.libra.tick.MultiTimer;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultTextTheme;
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
		
		protected var $hour:int;
		
		protected var $minute:int;
		
		protected var $second:int;
		
		protected var $prefixText:String;
		
		public function JCountDown(theme:DefaultTextTheme = null, x:int = 0, y:int = 0, prefixText:String = '') { 
			super(theme ? theme : UIManager.getInstance().theme.labelTheme, x, y);
			this.$prefixText = prefixText;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setLeftSecond(val:int):void {
			this.$hour = val / 3600;
			this.$minute = (val % 3600) / 60;
			this.$second = val % 60;
			invalidate(InvalidationFlag.DATA);
			MultiTimer.getInstance().addItem(this);
		}
		
		/* INTERFACE org.libra.tick.ITimerable */
		
		public function doAction():void {
			if (--$second < 0) {
				this.$second = 59;
				if (--$minute < 0) {
					this.$minute = 59;
					if (--$hour < 0) {
						this.$hour = this.$minute = this.$second = 0;
						MultiTimer.getInstance().removeItem(this);
						dispatchEvent(new Event(Event.COMPLETE));
					}
				}
			}
			invalidate(InvalidationFlag.DATA);
		}
		
		override public function clone():Component {
			return new JCountDown($theme, x, y, $prefixText);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function refreshData():void {
			text = this.$prefixText + toStr($hour) + ':' + toStr($minute) + ':' + toStr($second);
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
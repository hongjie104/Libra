package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.theme.DefaultPageCounterTheme;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.MathUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JPageCounter
	 * @author Eddie
	 * @qq 32968210
	 * @date 03/31/2013
	 * @version 1.0
	 * @see
	 */
	public class JPageCounter extends Component {
		
		protected var $maxVal:int;
		
		protected var $minVal:int;
		
		protected var $val:int;
		
		protected var prevBtn:JButton;
		
		protected var nextBtn:JButton;
		
		protected var counterLabel:JLabel;
		
		protected var theme:DefaultPageCounterTheme;
		
		public function JPageCounter(theme:DefaultPageCounterTheme, maxVal:int = 100, minVal:int = 0, x:int = 0, y:int = 0) { 
			super(x, y);
			this.theme = theme;
			setSize(theme.width, theme.height);
			this.$maxVal = maxVal;
			this.$minVal = minVal;
			$val = minVal;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			
			this.prevBtn = new JButton(theme.prevBtnTheme);
			this.nextBtn = new JButton(theme.nextBtnTheme);
			this.counterLabel = new JLabel(theme.countLabelTheme);
			counterLabel.textAlign = 'center';
			this.addChild(prevBtn);
			this.addChild(nextBtn);
			this.addChild(counterLabel);
		}
		
		public function set maxVal(val:int):void {
			if ($maxVal != val) {
				$maxVal = MathUtil.max(val, $minVal);
				$val = MathUtil.min($val, $maxVal);
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		public function get maxVal():int {
			return $maxVal;
		}
		
		public function set minVal(val:int):void {
			if ($minVal != val) {
				$minVal = MathUtil.min(val, $maxVal);
				$val = MathUtil.max($val, $minVal);
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		public function get minVal():int {
			return $minVal;
		}
		
		public function set val(val:int):void {
			if ($val != val) {
				$val = MathUtil.min($val, $maxVal);
				$val = MathUtil.max($val, $minVal);
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		public function get val():int {
			return $val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function resize():void {
			this.nextBtn.x = actualWidth - nextBtn.width;
			this.counterLabel.width = actualWidth - prevBtn.width - nextBtn.width;
			this.counterLabel.x = prevBtn.width;
		}
		
		override protected function refreshData():void {
			this.counterLabel.text = $val + '/' + $maxVal;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			prevBtn.addEventListener(MouseEvent.CLICK, onPrev);
			nextBtn.addEventListener(MouseEvent.CLICK, onNext);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			prevBtn.removeEventListener(MouseEvent.CLICK, onPrev);
			nextBtn.removeEventListener(MouseEvent.CLICK, onNext);
		}
		
		private function onPrev(e:MouseEvent):void {
			if (this.$val > $minVal) {
				this.$val--;
				invalidate(InvalidationFlag.DATA);
			}
		}
		
		private function onNext(e:MouseEvent):void {
			if (this.$val < $maxVal) {
				this.$val += 1;
				invalidate(InvalidationFlag.DATA);
			}
		}
	}

}
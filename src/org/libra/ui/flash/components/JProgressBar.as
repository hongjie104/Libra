package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.ContainerSkin;
	import org.libra.ui.flash.theme.ProgressBarSkin;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.asset.AssetsStorage;
	import org.libra.utils.displayObject.BitmapDataUtil;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JProgressBar
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class JProgressBar extends Container {
		
		protected var $maskShape:Shape;
		
		protected var $barShape:Shape;
		
		protected var $progress:Number;
		
		protected var $progressBarSkin:ProgressBarSkin;
		
		protected var $barWidth:int;
		
		public function JProgressBar(x:int = 0, y:int = 0, skin:ProgressBarSkin = null) { 
			super(x, y);
			$progress = .0;
			$progressBarSkin = skin ? skin : UIManager.getInstance().skin.progressBarSkin;
			super.setSize($progressBarSkin.width, $progressBarSkin.height);
			$barWidth = $progressBarSkin.barWidth;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			$maskShape = createShape();
			$barShape = createShape();
			this.addChild($maskShape);
			this.addChild($barShape);
			$barShape.mask = $maskShape;
			
			function createShape():Shape {
				var s:Shape = new Shape();
				s.cacheAsBitmap = true;
				s.x = $progressBarSkin.barX;
				s.y = $progressBarSkin.barY;
				return s;
			}
		}
		
		public function set progress(val:Number):void {
			$progress = val;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function get progress():Number {
			return $progress;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSize(w:int, h:int):void {
			//如果宽度改变了，那么barWidth也要跟着变，否则显示的进度就不对了
			//const t:int = this.$actualWidth - $barWidth;
			//$barWidth = w - t;
			//以上两个步骤整合到一起变成:$barWidth = w - this.$actualWidth + $barWidth;
			if ($actualWidth != w) {
				$barWidth = w - this.$actualWidth + $barWidth;
				this.invalidate(InvalidationFlag.DATA);
			}
			super.setSize(w, h);
		}
		
		override public function clone():Component {
			return new JProgressBar(x, y, $progressBarSkin);
		}
		
		override public function set skin(value:ContainerSkin):void {
			throw new Error('JProgressBar的皮肤无法使用该属性赋值');
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function resize():void {
			if ($background && $background is Bitmap) {
				if (($background as Bitmap).bitmapData) {
					($background as Bitmap).bitmapData.dispose();
				}
			}
			if ($actualWidth > 0 && $actualHeight > 0) {
				background = new Bitmap(BitmapDataUtil.getScale3BitmapData(AssetsStorage.getInstance().getBitmapData($progressBarSkin.barBgSkin), $actualWidth, $progressBarSkin.barBgScale9Rect, Constants.HORIZONTAL));
				var barBmd:BitmapData = BitmapDataUtil.getScale3BitmapData(AssetsStorage.getInstance().getBitmapData($progressBarSkin.barSkin), $barWidth, $progressBarSkin.barScale9Rect, Constants.HORIZONTAL);
				GraphicsUtil.drawRectWithBmd($maskShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
				GraphicsUtil.drawRectWithBmd($barShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
			}
		}
		
		override protected function refreshData():void {
			$maskShape.x = this.$progress * $barWidth - $barWidth + $progressBarSkin.barX;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
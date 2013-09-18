package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultContainerTheme;
	import org.libra.ui.flash.theme.DefaultProgressBarTheme;
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
		
		private var $maskShape:Shape;
		
		private var $barShape:Shape;
		
		private var $progress:Number;
		
		protected var $progressBarTheme:DefaultProgressBarTheme;
		
		public function JProgressBar(theme:DefaultProgressBarTheme = null, x:int = 0, y:int = 0) { 
			super(null, x, y);
			$progress = .0;
			$progressBarTheme = theme ? theme : UIManager.getInstance().theme.progressBarTheme;
			setSize($progressBarTheme.width, $progressBarTheme.height);
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
				s.x = $progressBarTheme.barX;
				s.y = $progressBarTheme.barY;
				return s;
			}
		}
		
		public function setProgress(val:Number):void {
			$progress = val;
			invalidate(InvalidationFlag.DATA);
		}
		
		override public function clone():Component {
			return new JProgressBar($progressBarTheme, x, y);
		}
		
		override public function set theme(value:DefaultContainerTheme):void {
			throw new Error('JProgressBar的主题无法使用该属性赋值');
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
				background = new Bitmap(BitmapDataUtil.getScale3BitmapData(AssetsStorage.getInstance().getBitmapData($progressBarTheme.barBgSkin), $actualWidth, $progressBarTheme.barBgScale9Rect, Constants.HORIZONTAL));
				var barBmd:BitmapData = BitmapDataUtil.getScale3BitmapData(AssetsStorage.getInstance().getBitmapData($progressBarTheme.barSkin), $progressBarTheme.barWidth, $progressBarTheme.barScale9Rect, Constants.HORIZONTAL);
				GraphicsUtil.drawRectWithBmd($maskShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
				GraphicsUtil.drawRectWithBmd($barShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
			}
		}
		
		override protected function refreshData():void {
			$maskShape.x = this.$progress * $progressBarTheme.barWidth - $progressBarTheme.barWidth + $progressBarTheme.barX;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.theme.DefaultProgressBarTheme;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.utils.ResManager;
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
		
		private var theme:DefaultProgressBarTheme;
		
		private var maskShape:Shape;
		
		private var barShape:Shape;
		
		private var progress:Number;
		
		public function JProgressBar(theme:DefaultProgressBarTheme, x:int = 0, y:int = 0) { 
			super(x, y);
			progress = .0;
			this.theme = theme;
			setSize(theme.width, theme.height);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			maskShape = createShape();
			barShape = createShape();
			this.addChild(maskShape);
			this.addChild(barShape);
			barShape.mask = maskShape;
			
			function createShape():Shape {
				var s:Shape = new Shape();
				s.cacheAsBitmap = true;
				s.x = theme.barX;
				s.y = theme.barY;
				return s;
			}
		}
		
		public function setProgress(val:Number):void {
			progress = val;
			invalidate(InvalidationFlag.DATA);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function resize():void {
			if (background && background is Bitmap) {
				if ((background as Bitmap).bitmapData) {
					(background as Bitmap).bitmapData.dispose();
				}
			}
			if (actualWidth > 0 && actualHeight > 0) {
				setBackground(new Bitmap(BitmapDataUtil.getScale3BitmapData(ResManager.getInstance().getBitmapData(theme.barBgResName), actualWidth, theme.barBgScale9Rect, Constants.HORIZONTAL)));
				var barBmd:BitmapData = BitmapDataUtil.getScale3BitmapData(ResManager.getInstance().getBitmapData(theme.barResName), theme.barWidth, theme.barScale9Rect, Constants.HORIZONTAL);
				GraphicsUtil.drawRectWithBmd(maskShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
				GraphicsUtil.drawRectWithBmd(barShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
			}
		}
		
		override protected function refreshData():void {
			maskShape.x = this.progress * theme.barWidth - theme.barWidth + theme.barX;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
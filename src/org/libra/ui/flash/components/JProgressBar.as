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
		
		protected var _maskShape:Shape;
		
		protected var _barShape:Shape;
		
		protected var _progress:Number;
		
		protected var _progressBarSkin:ProgressBarSkin;
		
		protected var _barWidth:int;
		
		public function JProgressBar(x:int = 0, y:int = 0, skin:ProgressBarSkin = null) { 
			super(x, y);
			_progress = .0;
			_progressBarSkin = skin ? skin : UIManager.instance.skin.progressBarSkin;
			super.setSize(_progressBarSkin.width, _progressBarSkin.height);
			_barWidth = _progressBarSkin.barWidth;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			_maskShape = createShape();
			_barShape = createShape();
			this.addChild(_maskShape);
			this.addChild(_barShape);
			_barShape.mask = _maskShape;
			
			function createShape():Shape {
				var s:Shape = new Shape();
				s.cacheAsBitmap = true;
				s.x = _progressBarSkin.barX;
				s.y = _progressBarSkin.barY;
				return s;
			}
		}
		
		public function set progress(val:Number):void {
			_progress = val;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function get progress():Number {
			return _progress;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSize(w:int, h:int):void {
			//如果宽度改变了，那么barWidth也要跟着变，否则显示的进度就不对了
			//const t:int = this._actualWidth - _barWidth;
			//_barWidth = w - t;
			//以上两个步骤整合到一起变成:_barWidth = w - this._actualWidth + _barWidth;
			if (_actualWidth != w) {
				_barWidth = w - this._actualWidth + _barWidth;
				this.invalidate(InvalidationFlag.DATA);
			}
			super.setSize(w, h);
		}
		
		override public function clone():Component {
			return new JProgressBar(x, y, _progressBarSkin);
		}
		
		override public function set skin(value:ContainerSkin):void {
			throw new Error('JProgressBar的皮肤无法使用该属性赋值');
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function resize():void {
			if (_background && _background is Bitmap) {
				if ((_background as Bitmap).bitmapData) {
					(_background as Bitmap).bitmapData.dispose();
				}
			}
			if (_actualWidth > 0 && _actualHeight > 0) {
				background = new Bitmap(BitmapDataUtil.getScale3BitmapData(AssetsStorage.instance.getBitmapData(_progressBarSkin.barBgSkin), _actualWidth, _progressBarSkin.barBgScale9Rect, Constants.HORIZONTAL));
				var barBmd:BitmapData = BitmapDataUtil.getScale3BitmapData(AssetsStorage.instance.getBitmapData(_progressBarSkin.barSkin), _barWidth, _progressBarSkin.barScale9Rect, Constants.HORIZONTAL);
				GraphicsUtil.drawRectWithBmd(_maskShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
				GraphicsUtil.drawRectWithBmd(_barShape.graphics, 0, 0, barBmd.width, barBmd.height, barBmd);
			}
		}
		
		override protected function refreshData():void {
			_maskShape.x = this._progress * _barWidth - _barWidth + _progressBarSkin.barX;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
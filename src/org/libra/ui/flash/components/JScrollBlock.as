package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.utils.asset.AssetsStorage;
	import org.libra.utils.displayObject.BitmapDataUtil;
	
	/**
	 * <p>
	 * 滚动条中的滑块
	 * </p>
	 *
	 * @class JScrollBlock
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JScrollBlock extends Component {
		
		/**
		 * 背景层
		 */
		private var _back:Bitmap;
		
		/**
		 * 前景层
		 */
		private var _fore:Bitmap;
		
		/**
		 * 方向。水平的还是垂直的
		 */
		private var _orientation:int;
		
		public function JScrollBlock(orientation:int = 1, x:int = 0, y:int = 0) {
			super(x, y);
			this._orientation = orientation;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override public function clone():Component {
			return new JScrollBlock(_orientation, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			
			_back = new Bitmap();
			this.addChild(_back);
			_fore = new Bitmap(AssetsStorage.instance.getBitmapData(_orientation == Constants.HORIZONTAL ? UIManager.instance.skin.scrollBlockSkin.hScrollThumb : UIManager.instance.skin.scrollBlockSkin.vScrollThumb));
			this.addChild(_fore);
		}
		
		override protected function resize():void {
			if (_back.bitmapData) _back.bitmapData.dispose();
			if (_orientation == Constants.HORIZONTAL) {
				var source:BitmapData = AssetsStorage.instance.getBitmapData(UIManager.instance.skin.scrollBlockSkin.hScrollBtnBg);
				_back.bitmapData = BitmapDataUtil.getScale9BitmapData(source, _actualWidth, _actualHeight, UIManager.instance.skin.scrollBlockSkin.hScrollBtnScale9Rect);
			}else {
				source = AssetsStorage.instance.getBitmapData(UIManager.instance.skin.scrollBlockSkin.vScrollBtnBg);
				_back.bitmapData = BitmapDataUtil.getScale9BitmapData(source, _actualWidth, _actualHeight, UIManager.instance.skin.scrollBlockSkin.vScrollBtnScale9Rect);
			}
			_fore.x = (_actualWidth - _fore.width) >> 1;
			_fore.y = (_actualHeight - _fore.height) >> 1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
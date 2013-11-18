package org.libra.ui.flash.managers {
	import flash.display.Sprite;
	import org.libra.ui.flash.components.JPanel;
	import org.libra.utils.displayObject.DepthUtil;
	import org.libra.utils.displayObject.GraphicsUtil;
	/**
	 * <p>
	 * 布局管理器
	 * </p>
	 *
	 * @class LayoutManager
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public final class LayoutManager {
		
		private static var _instance:LayoutManager;
		
		/**
		 * 游戏舞台的宽度
		 */
		public static var stageWidth:int;
		
		/**
		 * 游戏舞台的高度
		 */
		public static var stageHeight:int;
		
		private var _panelList:Vector.<JPanel>;
		
		private var _activatedPanel:JPanel;
		
		private var _modelSprite:Sprite;
		
		public function LayoutManager(singleton:Singleton) {
			_panelList = new Vector.<JPanel>();
			_modelSprite = new Sprite();
			resize(800, 600);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addPanel(p:JPanel):void {
			if (_panelList.indexOf(p) == -1) {
				_panelList[_panelList.length] = p;
				p.activated = true;
				if (_activatedPanel) _activatedPanel.activated = false;
				_activatedPanel = p;
				if(p.autoCenter)
					toCenter(p);
				if (p.model) {
					if (_modelSprite.parent == p.parent)
						DepthUtil.bringToTop(_modelSprite);
					else
						p.parent.addChild(_modelSprite);
					DepthUtil.bringToTop(p);
				}
			}
		}
		
		public function removePanel(p:JPanel):void {
			var index:int = _panelList.indexOf(p);
			if (index != -1) {
				_panelList.splice(index, 1);
				if (p.activated) {
					p.activated = false;
					const l:int = _panelList.length;
					if (l) {
						this._activatedPanel = _panelList[l - 1];
						this._activatedPanel.activated = true;
					}else {
						_activatedPanel = null;
					}
				}
				if (p.model) {
					if (_panelList.length && _panelList[_panelList.length - 1].model) {
						DepthUtil.bringToTop(_panelList[_panelList.length - 1]);
					}else {
						_modelSprite.parent.removeChild(_modelSprite);	
					}
				}
			}
		}
		
		public function resize(w:int, h:int):void { 
			stageWidth = w;
			stageHeight = h;
			GraphicsUtil.drawRect(_modelSprite.graphics, 0, 0, w, h, 0x000000, 0);
		}
		
		public static function get instance():LayoutManager {
			return _instance ||= new LayoutManager(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function toCenter(p:JPanel):void {
			p.x = (stageWidth - p.width) >> 1;
			p.y = (stageHeight - p.height) >> 1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

/**
 * @private
 */
final class Singleton{}
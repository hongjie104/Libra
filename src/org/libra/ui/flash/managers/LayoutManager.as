package org.libra.ui.flash.managers {
	import flash.display.Sprite;
	import org.libra.ui.flash.components.JPanel;
	import org.libra.utils.DepthUtil;
	import org.libra.utils.GraphicsUtil;
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
		
		private static var instance:LayoutManager;
		
		/**
		 * 游戏舞台的宽度
		 */
		public static var stageWidth:int;
		
		/**
		 * 游戏舞台的高度
		 */
		public static var stageHeight:int;
		
		private var panelList:Vector.<JPanel>;
		
		private var modelSprite:Sprite;
		
		public function LayoutManager(singleton:Singleton) {
			panelList = new Vector.<JPanel>();
			modelSprite = new Sprite();
			resize(800, 600);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addPanel(p:JPanel):void {
			if (panelList.indexOf(p) == -1) {
				panelList[panelList.length] = p;
				if(p.isAutoCenter())
					toCenter(p);
				if (p.isModel()) {
					p.parent.addChild(modelSprite);
					DepthUtil.bringToTop(p);
				}
			}
		}
		
		public function removePanel(p:JPanel):void {
			var index:int = panelList.indexOf(p);
			if (index != -1) {
				panelList.splice(index, 1);
				if (p.isModel()) {
					if (modelSprite.parent) modelSprite.parent.removeChild(modelSprite);
				}
			}
		}
		
		public function resize(w:int, h:int):void { 
			stageWidth = w;
			stageHeight = h;
			GraphicsUtil.drawRect(modelSprite.graphics, 0, 0, w, h, 0x000000, 0);
		}
		
		public static function getInstance():LayoutManager {
			return instance ||= new LayoutManager(new Singleton());
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
final class Singleton{}
package org.libra.ui.starling.managers {
	import flash.display.Stage;
	import starling.core.Starling;
	import starling.display.Sprite;
	//import starling.display.Sprite;
	/**
	 * <p>
	 * UI大管家
	 * </p>
	 *
	 * @class UIManager
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-30-2012
	 * @version 1.0
	 * @see
	 */
	public final class UIManager {
		
		/**
		 * 单例
		 * @private
		 */
		private static var instance:UIManager;
		
		/**
		 * 传统显示列表的舞台
		 * @private
		 */
		private var $stage:Stage;
		
		/**
		 * starling的根容器
		 * @private
		 */
		private var $starlingRoot:Sprite;
		
		/**
		 * 在舞台上的所有面板
		 * @private
		 */
		//private var panelList:Vector.<IPanel>;
		
		/**
		 * 构造函数
		 * @param	singleton
		 * @private
		 */
		public function UIManager(singleton:Singleton) {
			//panelList = new Vector.<IPanel>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 初始化uiManager
		 * 在使用ui框架之前就必需初始化
		 * @param	stage 传统显示列表中的stage
		 */
		public function init(stage:Stage):void {
			this.$stage = stage;
			//this.$uiContainer = uiContainer;
			//this.$theme = theme;
			$starlingRoot = Starling.current ? Starling.current.root as Sprite : null;
		}
		
		//public function get theme():DefaultTheme {
			//return $theme;
		//}
		
		/**
		 * 获取传统显示列表中的stage
		 * @return Stage
		 */
		public function get stage():Stage {
			return this.$stage;
		}
		
		//public function get uiContainer():Container {
			//return $uiContainer;
		//}
		
		/**
		 * 获取starling的根容器
		 * @return
		 */
		public function get starlingRoot():Sprite {
			return $starlingRoot;
		}
		
		/**
		 * 获取单例
		 * @return UIManager
		 */
		public static function getInstance():UIManager {
			return instance ||= new UIManager(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

/**
 * @private
 */
final class Singleton{}
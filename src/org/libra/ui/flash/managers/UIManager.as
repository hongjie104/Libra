package org.libra.ui.flash.managers {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import org.libra.ui.flash.components.JLoadingPanel;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.theme.DefaultTheme;
	import org.libra.utils.ui.KeyPoll;
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
		 * 鼠标事件，是否截流。
		 * 在实际开发中，截流可以提高效率，
		 * 但是在UI编辑器中，事件流被截，控件就无法被选取了
		 * 所以加了这个一个字段，在UI编辑器中将值设为false。
		 */
		public static var stopPropagation:Boolean = true;
		
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
		 * 在舞台上的所有面板
		 * @private
		 */
		//private var panelList:Vector.<IPanel>;
		
		/**
		 * 默认的主题
		 */
		private var $theme:DefaultTheme;
		
		private var $uiContainer:IContainer;
		
		/**
		 * 加载进度面板
		 */
		private var $loadingPanel:JLoadingPanel;
		
		/**
		 * 按键管理器
		 */
		private var $keyPoll:KeyPoll;
		
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
		public function init(stage:Stage, uiContainer:IContainer, theme:DefaultTheme):void {
			this.$stage = stage;
			this.$uiContainer = uiContainer;
			this.$theme = theme;
			$stage.addChild($uiContainer as DisplayObject);
			LayoutManager.getInstance().resize(stage.stageWidth, stage.stageHeight);
			$keyPoll = new KeyPoll(stage);
			
			this.$loadingPanel = new JLoadingPanel(uiContainer, theme.panelTheme);
		}
		
		public function get theme():DefaultTheme {
			return $theme ||= new DefaultTheme();
		}
		
		public function get keyPoll():KeyPoll {
			return $keyPoll;
		}
		
		/**
		 * 获取传统显示列表中的stage
		 * @return Stage
		 */
		public function get stage():Stage {
			return this.$stage;
		}
		
		public function get uiContainer():IContainer {
			return $uiContainer;
		}
		
		public function showLoading():void {
			this.$loadingPanel.show();
		}
		
		public function setLoadingProgress(val:Number):void {
			this.$loadingPanel.progress = val;
		}
		
		public function closeLoading():void {
			this.$loadingPanel.close();
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
package org.libra.ui.flash.managers {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import org.libra.ui.flash.components.JLoadingPanel;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.theme.Skin;
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
		 * 所以加了这个一个字段，在UI编辑器中将值设为true。
		 */
		public static var UI_EDITOR:Boolean = false;
		
		/**
		 * 单例
		 * @private
		 */
		private static var _instance:UIManager;
		
		/**
		 * 传统显示列表的舞台
		 * @private
		 */
		private var _stage:Stage;
		
		/**
		 * 在舞台上的所有面板
		 * @private
		 */
		//private var panelList:Vector.<IPanel>;
		
		/**
		 * 默认的皮肤
		 */
		private var _skin:Skin;
		
		private var _uiContainer:IContainer;
		
		/**
		 * 加载进度面板
		 */
		private var _loadingPanel:JLoadingPanel;
		
		/**
		 * 按键管理器
		 */
		private var _keyPoll:KeyPoll;
		
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
		public function init(stage:Stage, uiContainer:IContainer, skin:Skin):void {
			this._stage = stage;
			this._uiContainer = uiContainer;
			this._skin = skin;
			_stage.addChild(_uiContainer as DisplayObject);
			LayoutManager.instance.resize(stage.stageWidth, stage.stageHeight);
			_keyPoll = new KeyPoll(stage);
			
			this._loadingPanel = new JLoadingPanel(uiContainer, _skin.panelSkin);
		}
		
		public function get skin():Skin {
			return _skin ||= new Skin();
		}
		
		public function get keyPoll():KeyPoll {
			return _keyPoll;
		}
		
		/**
		 * 获取传统显示列表中的stage
		 * @return Stage
		 */
		public function get stage():Stage {
			return this._stage;
		}
		
		public function get uiContainer():IContainer {
			return _uiContainer;
		}
		
		public function showLoading():void {
			this._loadingPanel.show();
		}
		
		public function setLoadingProgress(val:Number):void {
			this._loadingPanel.progress = val;
		}
		
		public function closeLoading():void {
			this._loadingPanel.close();
		}
		
		/**
		 * 获取单例
		 * @return UIManager
		 */
		public static function get instance():UIManager {
			return _instance ||= new UIManager(new Singleton());
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
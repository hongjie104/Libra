package org.libra.ui.managers {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import org.libra.ui.components.JPanel;
	/**
	 * <p>
	 * Description
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
		
		private static var instance:UIManager;
		
		private var stage:Stage;
		
		private var panelList:Vector.<JPanel>;
		
		public function UIManager(singleton:Singleton) {
			panelList = new Vector.<JPanel>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function init(stage:Stage):void {
			this.stage = stage;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		public function getStage():Stage {
			return this.stage;
		}
		
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

class Singleton{}
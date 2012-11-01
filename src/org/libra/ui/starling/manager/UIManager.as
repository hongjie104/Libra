package org.libra.ui.starling.manager {
	import starling.display.Sprite;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class UIManager
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/27/2012
	 * @version 1.0
	 * @see
	 */
	public final class UIManager {
		
		private static var instance:UIManager;
		
		private var root:Sprite;
		
		public function UIManager(singleton:Singleton) {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function init(root:Sprite):void {
			this.root = root;
		}
		
		public function getRoot():Sprite {
			return this.root;
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
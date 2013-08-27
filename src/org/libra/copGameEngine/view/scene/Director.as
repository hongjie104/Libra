package org.libra.copGameEngine.view.scene {
	import org.libra.tick.ITickable;
	import org.libra.tick.Tick;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Director
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public class Director implements ITickable {
		
		private static var instance:Director;
		
		protected var $currentScene:IScene;
		
		protected var $sceneList:Vector.<IScene>;
		
		protected var $tickabled:Boolean;
		
		public function Director(singleton:Singleton) {
			$sceneList = new Vector.<IScene>();
			$tickabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addScene(val:IScene):Boolean {
			var i:int = this.$sceneList.length;
			while (--i > -1) {
				if ($sceneList[i].name == val.name) return false;
			}
			$sceneList.push(val);
			return true;
		}
		
		public function removeScene(val:IScene):Boolean {
			var i:int = this.$sceneList.length;
			while (--i > -1) {
				if ($sceneList[i].name == val.name) {
					$sceneList.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		
		public function clearScene():void {
			this.$sceneList.length = 0;
		}
		
		public function getScene(name:String):IScene {
			var i:int = this.$sceneList.length;
			while (--i > -1) {
				if ($sceneList[i].name == name) return $sceneList[i];
			}
			return null;
		}
		
		public function set currentScene(name:String):void {
			if ($currentScene) {
				$currentScene.close();
			}
			$currentScene = getScene(name);
			if ($currentScene) $currentScene.show();
		}
		
		public function get currentScene():String {
			return $currentScene.name;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			if($currentScene && $currentScene.tickabled)
				$currentScene.tick(interval);
		}
		
		public function get tickabled():Boolean {
			return $tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			$tickabled = value;
		}
		
		public static function getInstance():Director {
			if (instance) {
				return instance;
			}
			instance = new Director(new Singleton());
			Tick.getInstance().addItem(instance);
			return instance;
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
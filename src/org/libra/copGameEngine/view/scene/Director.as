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
		
		private static var _instance:Director;
		
		protected var _currentScene:IScene;
		
		protected var _sceneList:Vector.<IScene>;
		
		protected var _tickabled:Boolean;
		
		public function Director(singleton:Singleton) {
			_sceneList = new Vector.<IScene>();
			_tickabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addScene(val:IScene):Boolean {
			var i:int = this._sceneList.length;
			while (--i > -1) {
				if (_sceneList[i].name == val.name) return false;
			}
			_sceneList.push(val);
			return true;
		}
		
		public function removeScene(val:IScene):Boolean {
			var i:int = this._sceneList.length;
			while (--i > -1) {
				if (_sceneList[i].name == val.name) {
					_sceneList.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		
		public function clearScene():void {
			this._sceneList.length = 0;
		}
		
		public function getScene(name:String):IScene {
			var i:int = this._sceneList.length;
			while (--i > -1) {
				if (_sceneList[i].name == name) return _sceneList[i];
			}
			return null;
		}
		
		public function set currentScene(name:String):void {
			if (_currentScene) {
				_currentScene.close();
			}
			_currentScene = getScene(name);
			if (_currentScene) _currentScene.show();
		}
		
		public function get currentScene():String {
			return _currentScene.name;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			if(_currentScene && _currentScene.tickabled)
				_currentScene.tick(interval);
		}
		
		public function get tickabled():Boolean {
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			_tickabled = value;
		}
		
		public static function get instance():Director {
			if (instance) {
				return instance;
			}
			instance = new Director(new Singleton());
			Tick.instance.addItem(instance);
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
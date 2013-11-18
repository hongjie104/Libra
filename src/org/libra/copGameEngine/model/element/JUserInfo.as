package org.libra.copGameEngine.model.element {
	import org.libra.copGameEngine.model.basic.GameObject;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JUserInfo
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JUserInfo {
		
		protected var _account:String;
		
		protected var _password:String;
		
		//protected var _id:String;
		//
		//protected var _type:int;
		//
		//protected var _name:String;
		//
		//protected var _gender:int;
		
		private static var _instance:JUserInfo;
		
		/**
		 * 背包里的数据
		 */
		protected var _itemList:Vector.<JItem>;
		
		public function JUserInfo(singleton:Singleton) {
			_itemList = new Vector.<JItem>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		//public function get id():String {
			//return _id;
		//}
		//
		//public function set id(value:String):void {
			//_id = value;
		//}
		//
		//public function get type():int {
			//return _type;
		//}
		//
		//public function set type(value:int):void {
			//_type = value;
		//}
		
		public function get itemList():Vector.<JItem> {
			return _itemList;
		}
		
		//public function get name():String {
			//return _name;
		//}
		//
		//public function set name(value:String):void {
			//_name = value;
		//}
		//
		//public function get gender():int {
			//return _gender;
		//}
		//
		//public function set gender(value:int):void {
			//_gender = value;
		//}
		
		public function get account():String {
			return _account;
		}
		
		public function set account(value:String):void {
			_account = value;
		}
		
		public function get password():String {
			return _password;
		}
		
		public function set password(value:String):void {
			_password = value;
		}
		
		public function getItemCount(type:int):int {
			var count:int = 0;
			var i:int = this._itemList.length;
			while (--i > -1) {
				if (_itemList[i].type == type) {
					count += _itemList[i].count;
				}
			}
			return count;
		}
		
		public static function get instance():JUserInfo {
			return _instance ||= new JUserInfo(new Singleton());
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
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
		
		protected var $account:String;
		
		protected var $password:String;
		
		protected var $id:String;
		
		protected var $type:int;
		
		protected var $name:String;
		
		protected var $gender:int;
		
		private static var instance:JUserInfo;
		
		/**
		 * 背包里的数据
		 */
		protected var $itemList:Vector.<JItem>;
		
		public function JUserInfo(singleton:Singleton) {
			$itemList = new Vector.<JItem>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get id():String {
			return $id;
		}
		
		public function set id(value:String):void {
			$id = value;
		}
		
		public function get type():int {
			return $type;
		}
		
		public function set type(value:int):void {
			$type = value;
		}
		
		public function get itemList():Vector.<JItem> {
			return $itemList;
		}
		
		public function get name():String {
			return $name;
		}
		
		public function set name(value:String):void {
			$name = value;
		}
		
		public function get gender():int {
			return $gender;
		}
		
		public function set gender(value:int):void {
			$gender = value;
		}
		
		public function get account():String {
			return $account;
		}
		
		public function set account(value:String):void {
			$account = value;
		}
		
		public function get password():String {
			return $password;
		}
		
		public function set password(value:String):void {
			$password = value;
		}
		
		public function getItemCount(type:int):int {
			var count:int = 0;
			var i:int = this.$itemList.length;
			while (--i > -1) {
				if ($itemList[i].type == type) {
					count += $itemList[i].count;
				}
			}
			return count;
		}
		
		public static function getInstance():JUserInfo {
			return instance ||= new JUserInfo(new Singleton());
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
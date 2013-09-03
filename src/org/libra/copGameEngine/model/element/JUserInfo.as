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
	public class JUserInfo extends GameObject {
		
		private static var instance:JUserInfo;
		
		/**
		 * 背包里的数据
		 */
		protected var $itemList:Vector.<JItem>;
		
		public function JUserInfo(singleton:Singleton) {
			super();
			$itemList = new Vector.<JItem>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get itemList():Vector.<JItem> {
			return $itemList;
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
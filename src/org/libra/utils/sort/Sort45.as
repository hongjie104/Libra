package org.libra.utils.sort
{
	import org.libra.displayObject.interfaces.ISprite45;

	public final class Sort45
	{
		
		public function Sort45()
		{
			
		}
		
		/*public static function insertItem(target:ISprite45,itemList:Vector.<ISprite45>):Vector.<ISprite45>{
			const l:int = itemList.length;
			var tmpList:Vector.<ISprite45> = new Vector.<ISprite45>();
			tmpList[0] = target;
			//记录target在数组中的位置
			var index:int = 0;
			var item:ISprite45;
			for(var i:int = 0;i < l;i+=1){
				item = itemList[i];
				if((item.bottomX <= target.topX && item.topY <= target.bottomY) || (item.bottomY < target.topY)) {
					//插到targetq前面
					tmpList.splice(index++,0,item);
				}else {
					//tmpList.push(item);
					tmpList[tmpList.length] = item;
				}
			}
			return tmpList;
		}*/
		
		/**
		 * 获取物品在队列中的唯一深度
		 * 原理很简单，默认物品在最上层，然后遍历之前已经排好序的队列，直到找到在深度目标物品深度以下的，break
		 * 即可获得目标物品的正确深度了 
		 * @param target 目标物品
		 * @param itemList 已经排好序的物品队列
		 * @return  目标物品在队列中的深度
		 */		
		public static function getDepth(target:ISprite45,itemList:Vector.<ISprite45>):int{
			const l:int = itemList.length;
			var index:int = l;
			var item:ISprite45;
			while(--l > -1){
				item = itemList[l];
				if((item.bottomX <= target.topX && item.topY <= target.bottomY) || (item.bottomY < target.topY)) {
					break;
				}else{
					index--;
				}
			}
			return index;
		}
	}
}
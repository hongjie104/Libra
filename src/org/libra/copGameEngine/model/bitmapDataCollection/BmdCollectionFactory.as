package org.libra.copGameEngine.model.bitmapDataCollection {
	import org.libra.utils.asset.IAsset;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BmdCollectionFactory
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class BmdCollectionFactory {
		
		private static var _instance:BmdCollectionFactory;
		
		private var bmdList:Vector.<IAsset>;
		
		public function BmdCollectionFactory(singleton:Singleton) {
			bmdList = new Vector.<IAsset>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getBmdCollection(id:String, classType:Class):IAsset {
			var i:int = this.bmdList.length;
			while (--i > -1) {
				if (bmdList[i].id == id) {
					if(bmdList[i] is classType)
						return bmdList[i];
				}
			}
			var bmd:Object = new classType(id);
			bmdList.push(bmd);
			return bmd as IAsset;
		}
		
		public static function get instance():BmdCollectionFactory {
			return _instance ||= new BmdCollectionFactory(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
final class Singleton{}
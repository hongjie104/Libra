package org.libra.video {
	import flash.events.Event;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class CustomClient
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/27/2013
	 * @version 1.0
	 * @see
	 */
	public class CustomClient {
		
		private var $tar:VideoConnecter;
		
		public function CustomClient(tar:VideoConnecter) {
			$tar = tar;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function onMetaData(info:Object):void {
			$tar.videoWidth = info.width;
			$tar.videoHeight = info.height;
			$tar.dispatchEvent(new Event("videoInfoGet"));
			// info.duration info.width info.height  info.framerate;
		}
		
		public function onCuePoint(info:Object):void {
			//info.time  info.name  info.type;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
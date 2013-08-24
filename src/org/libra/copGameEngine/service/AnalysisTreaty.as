package org.libra.copGameEngine.service {
	import org.libra.log4a.Logger;
	import org.robotlegs.mvcs.Actor;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class AnalysisTreaty
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/29/2013
	 * @version 1.0
	 * @see
	 */
	public final class AnalysisTreaty{
		
		private var socketservice:SocketService;
		
		public function AnalysisTreaty(s:SocketService) {
			socketservice = s;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function Error(param:String):void {
			Logger.error(param);
		}
		
		public function LoginOK(param:String):void {
			//socketservice.signalBus.CREATE_USER_SIGNAL.dispatch(["createUser"]);
		}
		
		public function CharacterCount(param:int):void {
			if (param == 0) {
				//socketservice.signalBus.CREATE_USER_SIGNAL.dispatch(["createUser"]);
			}else {
				//socketservice.signalBus.ROOM_SIGNAL.dispatch(["updateRoom"]);
			}
		}
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
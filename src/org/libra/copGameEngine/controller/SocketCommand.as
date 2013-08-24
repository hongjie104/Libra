package org.libra.copGameEngine.controller {
	import com.apowo.dreamer.constant.URI;
	import org.libra.copGameEngine.events.SocketEvent;
	import org.libra.copGameEngine.service.SocketService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class SocketCommand
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/30/2013
	 * @version 1.0
	 * @see
	 */
	
	public class SocketCommand extends Command {
		
		[Inject]
		public var event:SocketEvent;
		
		[Inject]
		public var socketService:SocketService;
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
        override public function execute():void {
			switch(event.subType) {
				case SocketEvent.SEND:
					const ary:Array = event.data as Array;
					if (ary[0] == 'login') {
						socketService.connect(URI.ip, URI.port, ary[1], ary[2]);
					}else {
						socketService.send(ary);	
					}
					break;
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
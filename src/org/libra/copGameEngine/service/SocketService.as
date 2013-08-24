package org.libra.copGameEngine.service {
	import com.adobe.crypto.MD5;
	import flash.system.Security;
	import org.libra.log4a.Logger;
	import org.libra.socket.BaseSocket;
	import org.libra.socket.BaseSocketEvent;
	import org.libra.utils.text.StringUtil;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class SocketService
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/30/2013
	 * @version 1.0
	 * @see
	 */
	public final class SocketService extends Actor {
		
		private var account:String;
		
		private var password:String;
		
		/**
		 * 网络连接
		 * @private
		 */
		private var socket:BaseSocket;
		
		private var analysisTreaty:AnalysisTreaty;
		
		public function SocketService() {
			super();
			analysisTreaty = new AnalysisTreaty(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * socket发送消息
		 * @param	ary 发送给服务器的消息
		 */
		public function send(ary:Array):void { 
			if (socket) {
				var str:String = "";
				var s:String = "";
				var len:int = ary.length;
				
				for (var i:int = 0; i < len; i += 1 ) {
					s = StringUtil.replace(ary[i], " ", "\\b");
					str += str ? ' ' + s : s;
				}
				this.socket.send(str);
				Logger.info("send msg = " + str);
			}else {
				Logger.warn("已与服务器断开连接，请重新登录游戏！");
			}
		}
		
		public function connect(ip:String, port:int, account:String, password:String):void { 
			this.account = account;
			this.password = password;
			if (!socket) {
				initSocket(ip, port);
			}
			socket.connect();
			Logger.info('开始连接服务器，ip:' + ip + ',port:' + port + ',account:' + account + ',password:' + password);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function initSocket(ip:String, port:int):void { 
			Security.loadPolicyFile("xmlsocket://" + ip + ":" + port);
			if (socket) {
				this.closeSocket();
			}
			socket = new BaseSocket(ip, port);
			addSocketListeners(socket);
		}
		
		/**
		 * socket注册监听器
		 * @param	dispatcher:BaseSocket
		 */
		private function addSocketListeners(socket:BaseSocket):void {  
            socket.addEventListener(BaseSocketEvent.CLOSE, handler);  
            socket.addEventListener(BaseSocketEvent.CONNECT, handler);  
            socket.addEventListener(BaseSocketEvent.IO_ERROR, handler);  
            socket.addEventListener(BaseSocketEvent.SECURITY_ERROR, handler);  
            socket.addEventListener(BaseSocketEvent.SENDING, handler);  
            socket.addEventListener(BaseSocketEvent.RECEIVED, handler);  
            socket.addEventListener(BaseSocketEvent.DECODE_ERROR, handler);  
        }
		
		/**
		 * socket移除监听器
		 * @private
		 * @param	dispatcher:BaseSocket
		 */
		private function removeSocketListeners(socket:BaseSocket):void {
			socket.removeEventListener(BaseSocketEvent.CLOSE, handler);  
            socket.removeEventListener(BaseSocketEvent.CONNECT, handler);  
            socket.removeEventListener(BaseSocketEvent.IO_ERROR, handler);  
            socket.removeEventListener(BaseSocketEvent.SECURITY_ERROR, handler);  
            socket.removeEventListener(BaseSocketEvent.SENDING, handler);  
            socket.removeEventListener(BaseSocketEvent.RECEIVED, handler);  
            socket.removeEventListener(BaseSocketEvent.DECODE_ERROR, handler); 
		}
		
		private function closeSocket(msg:String = ""):void {
			removeSocketListeners(socket);
			this.socket.close();
			this.socket = null;
			if (msg) {
				Logger.warn('socket关闭:' + msg);
			}
		}
		
		private function receive(event:BaseSocketEvent):void {
			var data:String = event.getData();
			data = StringUtil.replace(data, "\\0", "");
			data = StringUtil.replace(data, "\\b", " ");
			data = StringUtil.replace(data, "\\n", "");
			data = StringUtil.replace(data, '\r\n', '');
			data = StringUtil.replace(data, "\\\"\"", "\\\"\\\"");
			if (data) {
				Logger.info("received data = " + data);
				analysisCmd(JSON.parse(data));
			}
        }
		
		/**
		 * 解析收到的消息
		 * @param	param
		 */
		private function analysisCmd(param:*):void {
			var cmd:String = param.Cmd;
			param = param.Par;
			if (this.analysisTreaty.hasOwnProperty(cmd)) {
				var fun:Function = this.analysisTreaty[cmd];
				fun(param);
			}else {
				Logger.warn("AnalysisTreaty类中，没有解析" + cmd + "协议！");
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function handler(event:BaseSocketEvent):void {
            switch(event.type) {
                case BaseSocketEvent.RECEIVED:
                    receive(event);
                break;
				case BaseSocketEvent.CLOSE:
					Logger.error('网络连接关闭');
					this.closeSocket();
                break;
				case BaseSocketEvent.CONNECT:
					//if (Externall.isLoginAuto()) {
						//var loginData:String = "{\"Command\":\"PlatformLogin\",\"Account\":\"" + account + "\",\"Password\":\"" + password + "\",\"IsAdult\":\"" + Externall.isAdult + "\"}";	
					//}else {
					var md5Password:String = MD5.hash(password).toLowerCase();
					var s:int = 999;
					var loginData:String = "{\"Command\":\"Login\",\"Account\":\"" + account + "\",\"Password\":\"" + md5Password + "\",\"ServerId\":" + s + "}";	
					//}
					//var loginData:String = "{\"Command\":\"" + (Externall.isLoginAuto() ? 'PlatformLogin' : 'Login') + "\",\"Account\":\"" + account + "\",\"Password\":\"" + password + "\"}";
					Logger.info(loginData);
					this.socket.send(loginData);
                break;
                case BaseSocketEvent.IO_ERROR:
                case BaseSocketEvent.SECURITY_ERROR:
					this.closeSocket("连接失败:" + event.type);
					//显示出服务器列表，让玩家可以再选择服务器
					//sendNotification(PicaTownCommands.SHOW_SERVER_LIST_AGAIN);
                break;
                case BaseSocketEvent.DECODE_ERROR:
					this.closeSocket("解码失败");
                break;
            }
        }
	}

}
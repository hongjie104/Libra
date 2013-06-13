package org.libra.socket {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import org.libra.socket.utils.RecBuff;
	import org.libra.utils.encrypt.Base64;
	
	/** 
	 * @author Eddie 
	 */ 
    public class BaseSocket extends EventDispatcher{
        
        private var _host:String;
        private var _port:int;
        private var _socket:Socket;
		private var buff:RecBuff;
		
        public function BaseSocket(host:String, port:int = 80) {
            this._host = host;
            this._port = port;
            this._socket = new Socket();
            this._socket.objectEncoding = ObjectEncoding.AMF3;
            //Security.loadPolicyFile("xmlsocket://" + this.host + ":" + this.port);
            this._socket.addEventListener(Event.CONNECT, handler);
            this._socket.addEventListener(Event.CLOSE, handler);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR, handler);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handler);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA, handler);
			buff = new RecBuff();
        }
        
        public function get host():String {
            return _host;
        }
        
        public function get port():int {
            return _port;
        }
        
        public function get connected():Boolean {
            return this._socket.connected;
        }
        
        public function connect():void {
            this._socket.connect(host, port);
        }
        
        public function close():void {
            this._socket.close();
        }
        
        public function send(params:String = null):void { 
            if(!this.connected || params == null){
                return;
            }
			params = Base64.encode(params + "\n");
            this._socket.writeMultiByte(params, "gb2312");
            this._socket.flush();
            this.dispatchEvent(new BaseSocketEvent(BaseSocketEvent.SENDING, params));
        }
		
		private function received():void {
			var temp:ByteArray = new ByteArray();
			this._socket.readBytes(temp, 0, _socket.bytesAvailable);
			var result:Array = buff.add(temp);
			for each(var str:String in result) {
				putOutMsg(str);
			}
		}
		
		private function putOutMsg(result:String):void {
			this.dispatchEvent(new BaseSocketEvent(BaseSocketEvent.RECEIVED, result));
		}
		
        //private function received():void { 
            //try {
				//var str:String = this._socket.readMultiByte(this._socket.bytesAvailable, "GB2312");
				//this.dispatchEvent(new BaseSocketEvent(BaseSocketEvent.RECEIVED, str));
            //}catch (error:Error) {
                //this.dispatchEvent(new BaseSocketEvent(BaseSocketEvent.DECODE_ERROR));
            //}
        //}
        
        private function handler(event:Event):void {
            switch(event.type) {
                case Event.CLOSE:
                    this.dispatchEvent(new BaseSocketEvent(BaseSocketEvent.CLOSE));
                break;
                case Event.CONNECT:
                case IOErrorEvent.IO_ERROR:
                case SecurityErrorEvent.SECURITY_ERROR:
                    this.dispatchEvent(new BaseSocketEvent(event.type));
                break;
                case ProgressEvent.SOCKET_DATA:
                    this.received();
                break;
            }
        }
    }

}
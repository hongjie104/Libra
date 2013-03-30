package org.libra.socket {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	/** 
	 * 自定义socket事件类。
     * @author Eddie
	 */ 
    public class BaseSocketEvent extends Event {
        
        public static const SECURITY_ERROR:String = SecurityErrorEvent.SECURITY_ERROR;
        public static const IO_ERROR:String = IOErrorEvent.IO_ERROR;
        public static const DECODE_ERROR:String = "decode_error";
        public static const RECEIVED:String = "received";
        public static const SENDING:String = "sending";
        public static const CLOSE:String = Event.CLOSE;
        public static const CONNECT:String = Event.CONNECT;
        
        private var data:String;
        
        public function BaseSocketEvent(type:String, data:String = null) {
            super(type, true);
            this.data = data;
        }
        
        public function getData():String {
            return data;
        }
        
        override public function toString():String {
            return formatToString("BaseSocketEvent", "type", "bubbles", "cancelable", "data");
        }
        
        override public function clone():Event {
            return new BaseSocketEvent(type, data);
        }
    }

}
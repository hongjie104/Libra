package org.libra.utils.externall {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class LocalDump extends EventDispatcher {
		
		public static const FLUSHED:String = "flushed";
		
		public static const PENDING:String = "pending";
		
		public static const FLUSHED_ERROR:String = "flushedError"
		
		private var myso:SharedObject;
		private var _name:String;
		private var _path:String;
		private var _minimumStorage:int;
		private var keyDict:Array;
		
		private static var instance:LocalDump;
		
	   /**
		* 堆名
		*/
	   public function get name():String { return _name; }
	   
	   /**
		* 路径
		*/
	   public function get path():String { return _path; }
	   
		/**
		 * 最小存储空间
		 */
		public function get minimumStorage():int { return _minimumStorage; }  
		
		public function set minimumStorage(value:int):void {
			_minimumStorage = value;
		}
   
		/**
		 * 构造函数
		 * @param name  名称
		 * @param path  本地存放路径
		 */
		public function LocalDump(name:String = "libra", localPath:String = "/", secure:Boolean = false, minimumStorage:int = 500):void { 
			super();
			myso = SharedObject.getLocal(name, localPath, secure);
			_minimumStorage = minimumStorage;
			keyDict = new Array();
		}
		
		/**
		 * 立即保存值
		 * @param key   键
		 * @param value  键值
		 */
		public function saveValue(key:String,value:*):void {
			myso.data[key] = value;
			keyDict[value] = key;
			flush();
		}
		
		/**
		 * 获取值
		 * @param key   指定的键名
		 * @return  objcet
		 */
		public function getValue(key:String):* {
			return myso.data[key];
		}  
		
		public function hasKey(key:String):Boolean {
			return myso.data.hasOwnProperty(key);
		}
		
		/**
		 * 获取键名
		 * @param value  指定的键值
		 * @return  String
		 */
		public function getKey(value:*):String{
			return keyDict[value];
		}
		
		/**
		 * 删除值
		 * @param key   指定要删除的键
		 */
		public function deleteValue(key:String):void {
			delete myso.data[key];
		}  
		
		/**
		 * 清除所有数据并删除共享对象
		 */
		public function destroy():void {
			myso.clear();
		}
		
		/**
		 * Deubg-only
		 * @return
		 */
		override public function toString():String {
			var s:String = "[LocalDump]{\n";
			for (var i:* in keyDict) { 
				s += "\tKey:" + keyDict + " Value:" + i + "\n";
			}
			s += "}";
			return s;
		}
		
		/**
		 * 立即写入本地
		 * @param minimumStorage
		 */
		protected function flush():void {
			var s:String ;
			try {
				s = myso.flush(_minimumStorage);
			}catch (e:Error) {
				dispatchEvent(new Event(FLUSHED_ERROR));
			}
			switch(s) {
				case "flushed":
					dispatchEvent(new Event(FLUSHED));
				break;
				case "pending":
					dispatchEvent(new Event(PENDING));
				break;
			}
		} 
		
		public static function getLocalDump():LocalDump {
			return instance ||= new LocalDump();
		}
	}
}
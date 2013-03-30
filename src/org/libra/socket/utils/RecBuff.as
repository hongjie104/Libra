package org.libra.socket.utils {
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class RecBuff {
		
		private var buff:ByteArray;
		private var tempBuff:ByteArray;
		private var command:int;
		private var length:int;
		private var status:int = 0;
		
		public function RecBuff(){
			buff = new ByteArray();
			buff.endian = Endian.LITTLE_ENDIAN;
			
			tempBuff = new ByteArray();
			tempBuff.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function add(temp:ByteArray):Array {
			var result:Array = [];
			buff.writeBytes(temp, temp.position, temp.bytesAvailable);
			buff.position = 0;
			
			if (status == 1){
				buff.position = 8;
				if (buff.bytesAvailable >= length){
					var ts:String = buff.readMultiByte(length, "gb2312");
					if (ts) result.push(ts);
					removeReadBuff();
					status = 0;
				} else {
					buff.position = buff.length;
				}
			}
			while (status == 0){
				if (buff.bytesAvailable < 8){
					if (buff.bytesAvailable > 0){
						buff.position = buff.length;
						break;
					}
					break;
				}
				command = buff.readInt();
				length = buff.readInt();
				if (command != 10000){
					buff.clear();
					break;
				}
				if (buff.bytesAvailable >= length){
					ts = buff.readMultiByte(length, "gb2312");
					if (ts) result.push(ts);
					removeReadBuff();
				} else {
					status = 1;
					buff.position = buff.length;
					break;
				}
			}
			return result;
		}
		
		private function removeReadBuff():void {
			tempBuff.clear();
			tempBuff.writeBytes(buff, buff.position, buff.bytesAvailable);
			tempBuff.position = 0;
			buff.clear();
			buff.position = 0;
			buff.writeBytes(tempBuff, tempBuff.position, tempBuff.bytesAvailable);
			buff.position = 0;
			tempBuff.position = 0;
		}
	}
	//import flash.utils.ByteArray;
	//import flash.utils.Endian;
	//
	///**
	 //* ...
	 //* @author ShareMing
	 //*/
	//public class RecBuff {
		//
		//private var buff:ByteArray;
		//private var command:int;
		//private var length:int;
		//private var status:int = 0;
		//
		//public function RecBuff(){
			//buff = new ByteArray();
			//buff.endian = Endian.LITTLE_ENDIAN;
		//}
		//
		//public function add(temp:ByteArray):Array {
			//var result:Array = [];
			//if (status == 1){
				//buff.position = buff.length;
			//}
			//buff.writeBytes(temp, temp.position, temp.bytesAvailable);
			//
			//buff.position = 0;
			//
			//if (status == 1){
				//if (buff.bytesAvailable >= length + 8){
					//buff.position = 8;
					//var ts:String = buff.readMultiByte(length, "gb2312");
					//var ts:String = buff.readMultiByte(buff.bytesAvailable, "gb2312");
					//if (ts) { 
						//result.push(ts);
					//}
					//status = 0;
				//}
			//}
			//while (status == 0){
				//if (buff.bytesAvailable < 8){
					//buff.clear();
					//return result;
				//}
				//command = buff.readInt();
				//length = buff.readInt();
				//if (command != 10000){
					//buff.position = 0;
					//length = buff.length;
				//}
				//if (buff.bytesAvailable >= length) { 
					//ts = buff.readMultiByte(length, "gb2312");
					//if (ts) { 
						//result.push(ts);
					//}
				//} else {
					//status = 1;
					//break;
				//}
				//if (buff.bytesAvailable < 8){
					//break;
				//}
			//}
			//if (buff.bytesAvailable == 0){
				//buff.clear();
			//}
			//return result;
		//}
	//}
}
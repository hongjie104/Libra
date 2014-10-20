package org.libra.utils
{
	import flash.filesystem.File;

	public final class FileUtil
	{
		public function FileUtil()
		{
		}
		
		public static function getFileArr(nativePath:String, extension:Array = null, filter:Boolean = false):Vector.<File>{
			var result:Vector.<File> = new Vector.<File>();
			//获取指定路径下的所有文件名
			var directory:File = new File(nativePath); 
			var contents:Array = directory.getDirectoryListing(); 
			for (var i:uint = 0; i < contents.length; i++) { 
				var file:File = contents[i] as File;
				if(file.isDirectory){
					result = result.concat(getFileArr(file.nativePath, extension));
				}else{
					if(extension && ArrayUtil.hasVal(extension, file.extension)){
						if(!filter || !isInList(file, result)){
							result.push(file);							
						}
					}
				}
			}
			return result;
		}
		
		private static function isInList(file:File, fileList:Vector.<File>):Boolean{
			var name:String = file.name.split(".")[0];
			var i:int = fileList.length;
			while(--i > -1){
				if(fileList[i].name.split(".")[0] == name) return true
			}
			return false;
		}
	}
}
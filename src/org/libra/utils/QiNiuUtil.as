package org.libra.utils
{
	import flash.events.DataEvent;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.Alert;

	public final class QiNiuUtil
	{
		public function QiNiuUtil()
		{
		}
		
		public static function upload(imageFile:File, imageName:String, token:String, onHandler:Function):void {
			var u :URLRequest = new URLRequest('http://upload.qiniu.com/');
			u.method = URLRequestMethod.POST;
			u.requestHeaders = [new URLRequestHeader('enctype', 'multipart/form-data')];
			
			var ur :URLVariables = new URLVariables();
			ur.key = imageName;
			ur.token = token;
//			ur['x:<custom_field_name>'] = '<Value of your custom param>';
			
			u.data = ur;
			
			imageFile.upload(u, 'file');
			// f is File or FileReference is both OK, but UploadDataFieldName must be 'file'
  			imageFile.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onHandler);
			imageFile.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		private static function onError(evt:IOErrorEvent):void{
			Alert.show(evt.text, '错误');
		}
		
//		private static function uploadedHandler(event:DataEvent):void {
//			trace(event.data);
//			//{
//			//  "hash":"<File etag>",
//			//  "key":"<Your file name in qiniu>",
//			//  "x:<custom_field_name>":"<Value of your custom param>"
//			//}
//		}
	}
}
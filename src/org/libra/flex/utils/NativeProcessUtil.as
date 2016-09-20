package org.libra.flex.utils
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	import org.libra.utils.text.StringUtil;

	public final class NativeProcessUtil
	{
		public function NativeProcessUtil()
		{
		}
		
		public static function runCMD(...args):void {
			//exe路径，经过测试，直接从system32下复制到程序的目录下也是没有问题的，前提是你的程序都是默认安装的。环境变量也没变
			var exePath:String = "C:/Windows/system32/cmd.exe";
			//启动参数
			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			info.executable = new File(exePath);
			var processArg:Vector.<String> = new Vector.<String>();
			//加上/c，是cmd的参数
			processArg[0] = "/c";
			for each(var arg:String in args) {
				processArg.push(arg);	
			}

			info.arguments= processArg;
			var process:NativeProcess = new NativeProcess();
			process.addEventListener(NativeProcessExitEvent.EXIT, packageOverHandler);
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, processOutputHandler);
			process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, processErrorHandler);
			process.start(info);
		}
		
		private static function packageOverHandler(event:NativeProcessExitEvent):void {
			var process:NativeProcess = event.target as NativeProcess;
			process.removeEventListener(NativeProcessExitEvent.EXIT, packageOverHandler);
			process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, processOutputHandler);
			process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, processErrorHandler);
//			if(event.exitCode == 0){
//				Alert.show("成功", '', Alert.OK, null, function(evt:CloseEvent):void{
//					_infoPanel.close();
//					//保存得到的game.zip
//					saveGameZIP();
//				});	
//			}else{
//				Alert.show("出错了", '', Alert.OK, null, function(evt:CloseEvent):void{
//					_infoPanel.showCloseBtn();
//				});
//			}
		}
		
		private static function processOutputHandler(e:ProgressEvent):void {
			var process:NativeProcess = e.target as NativeProcess;
			var info:String = process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable);
//			_infoPanel.addInfo('打包中:' + info);
			//				trace('打包中:' + info);
			//				if(info.indexOf('done') != -1){
			//					Alert.show("成功", '', Alert.OK, null, function(evt:CloseEvent):void{
			//						_infoPanel.close();
			//						//保存得到的game.zip
			//						saveGameZIP();
			//					});	
			//				}
		}
		
		private static function processErrorHandler(e:ProgressEvent):void {
			var process:NativeProcess = e.target as NativeProcess;
//			_infoPanel.addInfo('错误:' + process.standardError.readUTFBytes(process.standardError.bytesAvailable));
			
			process.removeEventListener(NativeProcessExitEvent.EXIT, packageOverHandler);
			process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, processOutputHandler);
			process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, processErrorHandler);
//			Alert.show("报错了");
		}
	}
}
/*
Copyright (c) 2008 EverythingFlex.com.
    http://code.google.com/p/everythingflexairlib/

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
package com.everythingflex.air.managers
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.NotificationType;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class IconManager
	{
		/**
        *  @private
        *  stores the Array of bitmaps tobe used as icons
        */
		private var sysDockIconBitmaps:Array = new Array();
		/**
        *  @private
        *  stores the Array of altered bitmaps tobe used as icons
        */
		private var alteredSysDockIconBitmaps:Array = new Array();
		/**
        *  @private
        *  used as an indicator to determine which state of icon to display
        */
		private var _count:int;	
		/**
        *  @private
        *  timer used to alternate between sysDockIcon and alteredSysDockIcon
        */
		private static var ALERT_TIMER:Timer;	
		/**
        *  Constructor.
        */
		public function IconManager(sysDockIconBitmaps:Array,
									alteredSysDockIconBitmaps:Array=null) {
			this.sysDockIconBitmaps = sysDockIconBitmaps;
			this.alteredSysDockIconBitmaps = alteredSysDockIconBitmaps;
			handleIcons();
		}
		/**
        *  @private
        *  called by constructor to initialize the icons sets
        */
		private function handleIcons():void{
			stopAlert();
			if(NativeApplication.supportsDockIcon || NativeApplication.supportsSystemTrayIcon){
				if(sysDockIconBitmaps.length > 0){
					NativeApplication.nativeApplication.icon.bitmaps = sysDockIconBitmaps;
					if(alteredSysDockIconBitmaps == null){
						alteredSysDockIconBitmaps = new Array();
						for (var i:int=0; i<sysDockIconBitmaps.length;i++){
							alteredSysDockIconBitmaps.push(applyAlertFilter(sysDockIconBitmaps[i].clone(),i));
						}	
					}		
				}
			}
		}
		/**
        *  @private
        *  alters icon to reverse of original using a filter
        */
		private function applyAlertFilter(bitmapData:BitmapData,i:int):BitmapData {
            var matrix:Array = new Array();
            matrix = matrix.concat([-1, 0, 0, 0, 255]);
            matrix = matrix.concat([0, -1, 0, 0, 255]);
            matrix = matrix.concat([0, 0, -1, 0, 255]);
            matrix = matrix.concat([0, 0, 0, 1, 0]);
            var r:Rectangle;
            if(i == 0)r= new Rectangle(0,0,16,16);
            if(i == 1)r= new Rectangle(0,0,32,32);
            if(i == 2)r= new Rectangle(0,0,48,48);
            if(i == 3)r= new Rectangle(0,0,128,128);       
			bitmapData.applyFilter(bitmapData,r,new Point(),new ColorMatrixFilter(matrix));
            return new Bitmap(bitmapData).bitmapData;
    	}
    	/**
        *  @public
        *  starts an alert 
        *  shows toolTip message (Windows Only)
        *  bounces the dock icon (Mac Only)
        */
    	public function startAlert(message:String="Alert",alertType:String=""):void{
	       	IconManager.ALERT_TIMER = new Timer(500,0);
	       	IconManager.ALERT_TIMER.addEventListener(TimerEvent.TIMER,changeIcon)
	       	IconManager.ALERT_TIMER.start();
	       	if(NativeApplication.supportsSystemTrayIcon){
	       		SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = message;
	       	}
	       	if(NativeApplication.supportsDockIcon){
	       		DockIcon(NativeApplication.nativeApplication.icon).bounce(alertType);
	       	}
       	} 	
       	/**
        *  @public
        *  stops an alert
        */
       	public function stopAlert():void{
       		if(NativeApplication.supportsSystemTrayIcon){
       			SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "";
       		}
       		try{
       			IconManager.ALERT_TIMER.stop();
       		} catch (e:Error){
       			
       		}
       	}
       	/**
        *  @private
        *  timer handler, alters state of icon
        */
       	private function changeIcon(event:TimerEvent):void{
       		if(_count == 0){
       			if(sysDockIconBitmaps.length){
       				NativeApplication.nativeApplication.icon.bitmaps = sysDockIconBitmaps;
       			} 
       			_count = 1;
       		} else {
       			if(alteredSysDockIconBitmaps.length){
       				NativeApplication.nativeApplication.icon.bitmaps = alteredSysDockIconBitmaps;
       			}
       			_count = 0;
       		}
       	}

	}
}
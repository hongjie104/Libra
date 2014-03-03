package com.everythingflex.air.components
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.NotificationType;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import mx.core.Window;
	import mx.events.AIREvent;

	public class SuperWindow extends Window {
		public static var MULTI_MENU_MODE:Boolean = false;
		public static var SHOW_SYSDOCK_MENU:Boolean = false;
		
		private var startMenuCount:int = 0;
		
		public var nm:NativeMenu = new NativeMenu();
		public var menuName:String = "";
		public var showContextMenu:Boolean = false;
		public var addWindowControls:Boolean = false;
		public var sysDockIconBitmaps:Array = new Array();
		public var alteredSysDockIconBitmaps:Array = new Array();
		public var alertMethod:String = "native";
		public var alertType:String = NotificationType.CRITICAL;
		
		private var defaultSysDockIconBitmaps:Array;
		private var alteredDefaultSysDockIconBitmaps:Array;
			
		private var _count:int;	
		private static var ALERT_TIMER:Timer;	
			
		[Embed(source="assets/icons/AIRApp_16.png")]
        private var Icon16:Class;	
        private var bitmap16:Bitmap = new Icon16();
        
        [Embed(source="assets/icons/AIRApp_32.png")]
        private var Icon32:Class;	
        private var bitmap32:Bitmap = new Icon32();
        
        [Embed(source="assets/icons/AIRApp_48.png")]
        private var Icon48:Class;	
        private var bitmap48:Bitmap = new Icon48();
		
		[Embed(source="assets/icons/AIRApp_128.png")]
        private var Icon128:Class;	
        private var bitmap128:Bitmap = new Icon128();
			
		private var winControls:NativeMenuItem = new NativeMenuItem("Controls");	
				
		private var a:SuperAlertWindow;		
				
		// constructor, add event listeners for complete and closing
		public function SuperWindow(){
			if(NativeApplication.supportsMenu){
				this.startMenuCount = NativeApplication.nativeApplication.menu.items.length;
			}
			this.addEventListener(AIREvent.WINDOW_COMPLETE,winComplete);
			this.addEventListener(Event.CLOSING,winGone);
			alteredDefaultSysDockIconBitmaps = new Array();
			defaultSysDockIconBitmaps = [bitmap16.bitmapData,
								  bitmap32.bitmapData,
								  bitmap48.bitmapData,
								  bitmap128.bitmapData];
			for (var i:int=0; i<defaultSysDockIconBitmaps.length;i++){
				alteredDefaultSysDockIconBitmaps.push(applyAlertFilter(defaultSysDockIconBitmaps[i].clone(),i));
			}
			super();
		}
		
		// when window is complete add event listener for activate and call handleMenus()
		private function winComplete(event:AIREvent):void{
			this.addEventListener(Event.ACTIVATE,nowActive);
			handleIcons();
			handleMenus();
		}
			
		// when window closes, call removeMenu()
		private function winGone(event:Event):void{	
			try{
				a.close();
			} catch (e:Error){
				
			}
			stopAlert();
			NativeApplication.nativeApplication.icon.bitmaps = defaultSysDockIconBitmaps;
			removeMenu();
		}
			
		/*
		if in single menu mode, remove all menus beyond index 1
		else if in multi menu mode, remove only the matching menu
		*/
		private function removeMenu():void{
			try{
				if(NativeApplication.supportsMenu){
					var l:int = NativeApplication.nativeApplication.menu.items.length;
					if(!MULTI_MENU_MODE){
						for(var i:int=startMenuCount; i<l; i++){
							NativeApplication.nativeApplication.menu.removeItemAt(i);
			      		}
					} else if(MULTI_MENU_MODE){
						for(var j:int=startMenuCount; j<l; j++){
							if(NativeApplication.nativeApplication.menu.getItemAt(j).label == this.menuName){
			      				NativeApplication.nativeApplication.menu.removeItemAt(j);
			      				break;
			      			}
						}
					}
				}
			} catch(e:Error){
				
			}
			if(SHOW_SYSDOCK_MENU && NativeApplication.supportsSystemTrayIcon){
            	SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = new NativeMenu();
         		SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "";
            }
            if(SHOW_SYSDOCK_MENU && NativeApplication.supportsDockIcon) {
            	DockIcon(NativeApplication.nativeApplication.icon).menu = new NativeMenu();
            }
		}
		
		// create menus 
		private function handleMenus():void{
			if(addWindowControls && winControls.submenu == null){
				this.nm.addItem(new NativeMenuItem("",true));
				this.nm.addItem(createWinControls());
			}
			// Windows
			if(NativeWindow.supportsMenu){
				this.nativeWindow.menu = this.nm;
			// Mac
			} else if(NativeApplication.supportsMenu){
				if(!this.menuName.length)this.menuName = this.title;
	    	  	var menuItem:NativeMenuItem = new NativeMenuItem(this.menuName);
	      		menuItem.submenu = this.nm;
	      		removeMenu();
				NativeApplication.nativeApplication.menu.addItem(menuItem);
			}
			// if showContext menu is true, add a context menu
			if(showContextMenu)this.contextMenu = this.nm;
			// if SHOW_SYSDOCK_MENU is true, add menu to system tray icon
			if(SHOW_SYSDOCK_MENU && NativeApplication.supportsSystemTrayIcon){
            	SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = this.nm;
            	SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = this.title;
            }
            // if SHOW_SYSDOCK_MENU is true, add mnenu to dock icon
            if(SHOW_SYSDOCK_MENU && NativeApplication.supportsDockIcon) {
            	DockIcon(NativeApplication.nativeApplication.icon).menu = this.nm;
            }
		}
			
		// change NativeMenu to active windows nativeMenu on Mac
		private function nowActive(e:Event):void{
			handleIcons();
			handleMenus();
		}
		
		private function handleIcons():void{
			stopAlert();
			if(NativeApplication.supportsDockIcon || NativeApplication.supportsSystemTrayIcon){
				if(sysDockIconBitmaps.length > 0){
					NativeApplication.nativeApplication.icon.bitmaps = sysDockIconBitmaps;
					if(!alteredSysDockIconBitmaps.length){
						alteredSysDockIconBitmaps = new Array();
						for (var i:int=0; i<sysDockIconBitmaps.length;i++){
							alteredSysDockIconBitmaps.push(applyAlertFilter(sysDockIconBitmaps[i].clone(),i));
						}	
					}		
				} else {
					NativeApplication.nativeApplication.icon.bitmaps = defaultSysDockIconBitmaps;
				}
			}
		}
		
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
    	
       	public function startAlert(message:String="Alert"):void{
       		// check for alertMethod
       		if(alertMethod == "native"){
	       		if(NativeApplication.supportsDockIcon){
					DockIcon(NativeApplication.nativeApplication.icon).bounce(alertType);
				}
				if(NativeWindow.supportsNotification){
					this.nativeWindow.notifyUser(alertType);
				}
       		}
       		// check for alertMethod
       		if(alertMethod == "toast"){
	       		a  = new SuperAlertWindow();
	       		if(this.alertType == NotificationType.CRITICAL){
	       			a.delayTime = 0;
	       			a.notify = true;
	       		}
			    a.alertMessage = message;
			    a.alertType = this.alertType;
			    a.open();
       		}
       		stopAlert();
       		_count=0;
       		// check for alertMethod
       		if(alertMethod == "icon"){
	       		SuperWindow.ALERT_TIMER = new Timer(500,0);
	       		SuperWindow.ALERT_TIMER.addEventListener(TimerEvent.TIMER,changeIcon)
	       		SuperWindow.ALERT_TIMER.start();
	       		if(NativeApplication.supportsSystemTrayIcon){
	       			SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = message;
	       		}
       		}
       		
       	} 	
       	
       	public function stopAlert():void{
       		if(NativeApplication.supportsSystemTrayIcon){
       			SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = this.title;
       		}
       		try{
       			SuperWindow.ALERT_TIMER.stop();
       		} catch (e:Error){
       			
       		}
       	}
       	
       	private function changeIcon(event:TimerEvent):void{
       		if(_count == 0){
       			if(sysDockIconBitmaps.length){
       				NativeApplication.nativeApplication.icon.bitmaps = sysDockIconBitmaps;
       			} else {
       				NativeApplication.nativeApplication.icon.bitmaps = defaultSysDockIconBitmaps;
       			}
       			_count = 1;
       		} else {
       			if(alteredSysDockIconBitmaps.length){
       				NativeApplication.nativeApplication.icon.bitmaps = alteredSysDockIconBitmaps;
       			} else {
       				NativeApplication.nativeApplication.icon.bitmaps = alteredDefaultSysDockIconBitmaps;
       			}
       			_count = 0;
       		}
       	}
       	
        private function createWinControls():NativeMenuItem{
			var minimizeMenu:NativeMenuItem = new NativeMenuItem("Minimize");
	        var maximizeMenu:NativeMenuItem = new NativeMenuItem("Maximize");
	        var restoreMenu:NativeMenuItem = new NativeMenuItem("Restore");
	        var closeMenu:NativeMenuItem = new NativeMenuItem("Close");
	        minimizeMenu.addEventListener(Event.SELECT, handleMenuClick);
	        maximizeMenu.addEventListener(Event.SELECT, handleMenuClick);
	        restoreMenu.addEventListener(Event.SELECT, handleMenuClick);
	        closeMenu.addEventListener(Event.SELECT, handleMenuClick);
	        var subMenu:NativeMenu = new NativeMenu();
	        subMenu.addItem(minimizeMenu);
	        subMenu.addItem(maximizeMenu);
	        subMenu.addItem(restoreMenu);
	        subMenu.addItem(closeMenu);
	        winControls.submenu = subMenu;
	        return winControls;
		}	
		
		private function handleMenuClick(e:Event):void{
          var menuItem:NativeMenuItem = e.target as NativeMenuItem;
                if(menuItem.label == "Minimize") this.minimize();
                if(menuItem.label == "Maximize") this.maximize();
                if(menuItem.label == "Restore") this.restore();
                if(menuItem.label == "Close") this.close();
         }	
	}
}
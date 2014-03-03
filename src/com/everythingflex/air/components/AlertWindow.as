package com.everythingflex.air.components
{
	import com.everythingflex.flex.effects.MoveBounceTweenEffect;
	
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.Window;
	import mx.events.AIREvent;

	
	/**
	 * AlertWindow
	 * 
	 * @author Rich Tretola (EverythingFlex.com)
	 * @see http://blog.everythingflex.com/apollo/components-air/
	 */
	public class AlertWindow extends Window
	{
		/**
		 * @private
		 * Timer for show animation
		 */
		private var _showTimer:Timer;
		/**
		 * @private
		 * Timer for delay period
		 */
		private var _delayTimer:Timer;
		/**
		 * @private
		 * Timer for hide animation
		 */
		private var _hideTimer:Timer;
		/**
		 * @private
		 * Timer for bounce animation
		 */
		private var _bounceTimer:Timer;
		 
		/**
		 * @private
		 * int determines how high the AlertWindow will rise
		 */
		private var upY:int;
		
		/**
		 * @public
		 * int which determines the length of time to show AlertMXWindow
		 * defaults to 3
		 * enter a 0 for a permanent window to use bounce animation
		 */
		public var delayTime:int = 3;
		
		/**
		 * @public
		 * Boolean if true and delayTime is 0, will show bounce animation
		 */
		public var notify:Boolean = true;
		
		/**
		 * @public
		 * int final y position of window
		 */
		public var riseTo:int = 0;
		
		/**
		 * Constructor.
		 */
		public function AlertWindow()
		{
			this.layout = "absolute";
			this.alwaysInFront = true;
			this.resizable = false; 
			this.transparent = false;
			this.maximizable = false;
			this.minimizable = false;
			this.addEventListener(AIREvent.WINDOW_COMPLETE,winComplete);
            super.systemChrome = NativeWindowSystemChrome.ALTERNATE;
            super.type = NativeWindowType.UTILITY;
		}
		
		/**
		 * @private
		 * called on completion of window to set position and start timer
		 */
		private function winComplete(event:AIREvent):void{
			this.addEventListener(Event.CLOSE,closeIt);
            this.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
		    this.nativeWindow.x = flash.display.Screen.mainScreen.bounds.width - (this.width + 20);
		    this.nativeWindow.y = flash.display.Screen.mainScreen.bounds.height - 40;
			_showTimer = new Timer(20,0);
	        _showTimer.addEventListener("timer", showTimerHandler);
	        _showTimer.start();
		}
		/**
		 * @private
		 * override open() function
		 */
		override public function open(openWindowActive:Boolean = true):void{
		    super.open(openWindowActive);
		}
		/**
		 * @private
		 * handle timer and move alert window up to the riseTo position
		 * if window meets its goal position, either start delay timer or
		 * if notify is true start bounce timer 
		 */
		private function showTimerHandler(event:TimerEvent):void {
	        this.nativeWindow.y -= 10;
	        if(this.riseTo == 0) riseTo = flash.display.Screen.mainScreen.bounds.height - (this.height + 80);
	        if(this.nativeWindow.y <= this.riseTo){
	        	_showTimer.stop();
	        	if(delayTime > 0){
	        		_delayTimer = new Timer(1000,delayTime);
	            	_delayTimer.addEventListener("timer", delayTimerHandler);
	            	_delayTimer.start();
	         	}else if (notify){
	         		upY = this.riseTo;
	         		_bounceTimer = new Timer(1000,0);
	            	_bounceTimer.addEventListener("timer", bounceTimerHandler);
	            	_bounceTimer.start();
	         	}
	        }
        }
	    /**
		 * @private
		 * bounce window until it is interacted with
		 */
	    private function bounceTimerHandler(event:TimerEvent):void {
	    	if(!this.closed){
	    		var bounceIt:MoveBounceTweenEffect = new MoveBounceTweenEffect(this.nativeWindow);
	        	bounceIt.yFrom = upY;
	        	bounceIt.yTo = upY + 20;
	        	bounceIt.play();
	     	}
	    }
	    /**
		 * @private
		 * pause window at riseTo position until repeatCount is met
		 * then start the hide timer
		 */
        private function delayTimerHandler(event:TimerEvent):void {
        	var t:Timer = Timer(event.target);
	        if(t.currentCount == _delayTimer.repeatCount){
	        	_hideTimer = new Timer(20,999);
	            _hideTimer.addEventListener("timer", hideTimerHandler);
	            _hideTimer.start();
	        }
        }
	    /**
		 * @private
		 * handle hide timer and move window back down and off screen
		 */
        private function hideTimerHandler(event:TimerEvent):void {
        	if(!this.closed){
	         	this.nativeWindow.y += 10;
		        if(this.nativeWindow.y >= (flash.display.Screen.mainScreen.bounds.height-80)){
		        	this.close();
		        	_hideTimer.stop();
		        	try{_bounceTimer.stop();} catch (e:Error){}
		        }
	        }
        }	
        /**
		 * @private
		 * on close of window, stop all timers
		 */
        private function closeIt(event:Event):void{
	        try{_showTimer.stop();} catch (e:Error){}
	        try{_delayTimer.stop();} catch (e:Error){}
	        try{_hideTimer.stop();} catch (e:Error){}
	        try{_bounceTimer.stop();} catch (e:Error){}
	    }
	    /**
		 * @private
		 * if window is bouncing (notify) stop it on mouse over
		 */    
	    private function mouseOver(event:MouseEvent):void{
	        try{_bounceTimer.stop();} catch (e:Error){}
	    }
	        	
	}
}
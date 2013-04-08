package org.libra.bmpEngine.single {
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BitmapFrame
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public class BitmapFrame {
		
		/**
		 * 公共静态常量：原点，x和y都是0的点。
		 */
		//private static const ZERO_POINT:Point = new Point();
		
		protected var bmd:BitmapData;
		
		protected var index:int;
		
		protected var label:String;
		
		protected var funList:Vector.<FrameFun>;
		
		protected var $x:Number;
		
		protected var $y:Number;
		
		//private var $width:int;
		//
		//private var $height:int;
		//
		//protected var renderLayerList:Vector.<RenderLayer>;
		//
		//private var needRender:Boolean;
		
		public function BitmapFrame(index:int, bmd:BitmapData, x:Number = 0, y:Number = 0, label:String = null) { 
			this.index = index;
			this.bmd = bmd;
			//if (bmd) {
				//$width = bmd.width;
				//$height = bmd.height;
			//}
			this.$x = x;
			this.$y = y;
			this.label = label;
			//needRender = false;
			
			//renderLayerList = new Vector.<RenderLayer>();
			//var layer:RenderLayer = new RenderLayer();
			//renderLayerList[0] = layer; 
			//layer.addItem(new RenderItem(bmd));
			//layer.setBitmapFrame(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getIndex():int {
			return this.index;
		}
		
		public function getBmd():BitmapData {
			//if (needRender) {
				//this.bmd.fillRect(this.bmd.rect, 0x00000000);
				//var layer:RenderLayer;
				//for (var i:* in renderLayerList) {
					//layer = renderLayerList[i];
					//layer.render();
					//if (layer.visible) {
						//var bmd:BitmapData = layer.getBmd();
						//if(bmd)
							//this.bmd.copyPixels(bmd, bmd.rect, ZERO_POINT, null, null, true);
					//}
				//}
				//needRender = false;
			//}
			return this.bmd;
		}
		
		public function getLabel():String {
			return this.label;
		}
		
		public function addFun(fun:Function, params:Array = null, disposeEnabled:Boolean = false):void {
			var frameFun:FrameFun = new FrameFun(fun, params, disposeEnabled);
			if (!funList) funList = new Vector.<FrameFun>();
			if(funList.indexOf(frameFun) == -1)
				this.funList[funList.length] = frameFun;
		}
		
		public function removeFun(fun:Function):void {
			var index:int = this.funList.indexOf(fun);
			if (index != -1) this.funList.splice(index, 1);
		}
		
		public function doFun():void {
			if (this.funList) {
				var list:Vector.<FrameFun> = this.funList.slice();
				for (var i:* in list) {
					list[i].doFun();
					if (list[i].isDisposeEnabled()) {
						this.funList.splice(i, 1);
					}
				}
			}
		}
		
		/**
		 * 拷贝，本方法将生成一个BmpFrame对象
		 * 但是并不会克隆位图，只会传递位图的引用给新对象
		 * @return
		 */
		public function clone():BitmapFrame {
			var frame:BitmapFrame = new BitmapFrame(index, bmd, x, y, label);
			frame.funList = this.funList ? this.funList.slice() : null;
			return frame;
		}
		
		/**
		 * 增加层
		 * @param	l 将要被增加的层
		 */
		//public function addLayer(l:RenderLayer):void {
			//addLayerAt(l);
		//}
		//
		//public function addLayerAt(l:RenderLayer, index:int = -1):void {
			//if (this.renderLayerList.indexOf(l) == -1) {
				//index = index < 0 ? this.renderLayerList.length : (index > renderLayerList.length ? renderLayerList.length : index);
				//this.renderLayerList.splice(index, 0, l);
				//l.setBitmapFrame(this);
				//l.setSize($width, $height);
				//needRender = true;
			//}
		//}
		
		/**
		 * 移除层
		 * @param	l 将要被移除的层
		 */
		//public function removeLayer(l:RenderLayer):void {
			//removeLayerAt(this.renderLayerList.indexOf(l));
		//}
		//
		//public function removeLayerAt(index:int):void {
			//if (index < 0 || index >= this.renderLayerList.length) return;
			//this.renderLayerList.splice(index, 1);
			//needRender = true;
		//}
		
		//public function setSize(w:int, h:int):void {
			//if (this.bmd) bmd.dispose();
			//$width = w;
			//$height = h;
			//bmd = new BitmapData(w, h, true, 0);
			//for each(var l:RenderLayer in renderLayerList) {
				//l.setSize(w, h);	
			//}
		//}
		//
		//public function setNeedRender(boolean:Boolean):void {
			//this.needRender = boolean;
		//}
		
		/**
		 * 释放
		 * @param gcBmd是否释放本帧对应的位图数据,默认不释放 false
		 */
		public function dispose(gcBmd:Boolean = false):void {
			if (gcBmd && this.bmd) { 
				bmd.dispose();
			}
			bmd = null;
			label = null;
			for (var i:* in this.funList) {
				funList[i].dispose();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters ans setters
		-------------------------------------------------------------------------------------------*/
		
		public function get x():Number { 
			return this.$x;
		}
		
		public function set x(val:Number):void {
			this.$x = val;
		}
		
		public function get y():Number {
			return this.$y;
		}
		
		public function set y(val:Number):void {
			this.$y = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

class FrameFun {
	
	private var fun:Function;
	private var params:Array;
	private var disposeEnabled:Boolean;
	
	public function FrameFun(fun:Function, params:Array = null, disposeEnabled:Boolean = false) { 
		this.fun = fun;
		this.params = params;
		this.disposeEnabled = disposeEnabled;
	}
	
	public function isDisposeEnabled():Boolean {
		return this.disposeEnabled;
	}
	
	public function doFun():void { 
		fun.apply(null, params);
	}
	
	public function dispose():void {
		this.fun = null;
		this.params = null;
	}
}
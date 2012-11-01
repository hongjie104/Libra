package org.libra.ui.starling.core {
	import com.greensock.loading.BinaryDataLoader;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import org.libra.starling.ui.manager.ScrollRectManager;
	import org.libra.utils.MathUtil;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.MatrixUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseComponent
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/27/2012
	 * @version 1.0
	 * @see
	 */
	public class Component extends Sprite implements IDisplayObjectWithScrollRect { 
		
		private static var helpPoint:Point = new Point();
		private static var helpMatrix:Matrix = new Matrix();
		private static var helpRect:Rectangle = new Rectangle();
		
		protected var background:DisplayObject;
		
		protected var enabled:Boolean;
		
		protected var toolTipText:String;
		
		protected var inited:Boolean;
		
		protected var scrollRect:Rectangle;
		
		private var scaledScrollRectXY:Point;
		
		private var scissorRect:Rectangle;
		
		private var validationQueue:ValidationQueue;
		
		private var invalidationFlag:InvalidationFlag;
		
		protected var actualWidth:int;
		
		protected var actualHeight:int;
		
		public function Component(width:int, height:int, x:int = 0, y:int = 0) { 
			super();
			this.x = x;
			this.y = y;
			invalidationFlag = new InvalidationFlag();
			this.setSize(width, height);
			enabled = true;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			if (actualHeight != height  || actualWidth != width) {
				this.actualWidth = width;
				this.actualHeight = height;
				this.invalidate(InvalidationFlag.SIZE);
			}
		}
		
		override public function get width():Number {
			return actualWidth;
		}
		
		override public function set width(value:Number):void {
			if (actualWidth != value) {
				actualWidth = value;
				this.invalidate(InvalidationFlag.SIZE);
			}
		}
		
		override public function get height():Number {
			return actualHeight;
		}
		
		override public function set height(value:Number):void {
			if (actualHeight != value) {
				actualHeight = value;
				this.invalidate(InvalidationFlag.SIZE);
			}
		}
		
		public function setLocation(x:int, y:int):void {
			this.x = x;
			this.y = y;
		}
		
		public function setEnabled(val:Boolean):void {
			if (enabled == val) return;
			this.enabled = val;
			this.touchable = val;				
			this.invalidate(InvalidationFlag.STATE);
		}
		
		public function isEnabled():Boolean {
			return this.enabled;
		}
		
		public function setBackground(background:DisplayObject, disposeOld:Boolean = false):void { 
			if (this.background) background.removeFromParent(disposeOld);
			
			if (background) {
				this.addChildAt(background, 0);
			}
			this.background = background;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (this.background) {
				index = MathUtil.max(1, index);
			}
			return super.addChildAt(child, index);
		}
		
		public function setToolTipText(text:String):void {
			this.toolTipText = text;
			//ToolTipManager.getInstance().setToolTip(this, text ? JToolTip.getInstance() : null);
		}
		
		public function initToolTip():void {
			//JToolTip.getInstance().text = this.toolTipText;
		}
		
		public function getScrollRect():Rectangle {
			return this.scrollRect;
		}
		
		public function setScrollRect(value:Rectangle):void {
			this.scrollRect = value;
			if (this.scrollRect) { 
				if(!this.scaledScrollRectXY) this.scaledScrollRectXY = new Point();
				if (!this.scissorRect) this.scissorRect = new Rectangle();
			}else { 
				this.scaledScrollRectXY = null;
				this.scissorRect = null;
			}
		}
		
		override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle { 
			if (this.scrollRect) {
				if (!resultRect) resultRect = new Rectangle();
				if (targetSpace == this) { 
					resultRect.x = 0;
					resultRect.y = 0;
					resultRect.width = this.scrollRect.width;
					resultRect.height = this.scrollRect.height;
				}else { 
					this.getTransformationMatrix(targetSpace, helpMatrix);
					MatrixUtil.transformCoords(helpMatrix, 0, 0, helpPoint);
					resultRect.x = helpPoint.x;
					resultRect.y = helpPoint.y;
					resultRect.width = helpMatrix.a * this.scrollRect.width + helpMatrix.c * this.scrollRect.height;
					resultRect.height = helpMatrix.d * this.scrollRect.height + helpMatrix.b * this.scrollRect.width;
				}
				return resultRect;
			}
			return super.getBounds(targetSpace, resultRect);
		}
		
		override public function render(support:RenderSupport, alpha:Number):void { 
			if (this.scrollRect) { 
				const scale:Number = Starling.contentScaleFactor;
				this.getBounds(this.stage, this.scissorRect);
				this.scissorRect.x *= scale;
				this.scissorRect.y *= scale;
				this.scissorRect.width *= scale;
				this.scissorRect.height *= scale;
				
				this.getTransformationMatrix(this.stage, helpMatrix);
				this.scaledScrollRectXY.x = this.scrollRect.x * helpMatrix.a;
				this.scaledScrollRectXY.y = this.scrollRect.y * helpMatrix.d;
				
				const oldRect:Rectangle = ScrollRectManager.currentScissorRect;
				if (oldRect) { 
					this.scissorRect.x += ScrollRectManager.scrollRectOffsetX * scale;
					this.scissorRect.y += ScrollRectManager.scrollRectOffsetY * scale;
					this.scissorRect = this.scissorRect.intersection(oldRect);
				}
				//isEmpty() && <= 0 don't work here for some reason
				if(this.scissorRect.width < 1 || this.scissorRect.height < 1 ||
					this.scissorRect.x >= Starling.current.nativeStage.stageWidth ||
					this.scissorRect.y >= Starling.current.nativeStage.stageHeight ||
					(this.scissorRect.x + this.scissorRect.width) <= 0 ||
					(this.scissorRect.y + this.scissorRect.height) <= 0) { 
					return;
				}
				support.finishQuadBatch();
				Starling.context.setScissorRectangle(this.scissorRect);
				ScrollRectManager.currentScissorRect = this.scissorRect;
				ScrollRectManager.scrollRectOffsetX -= this.scaledScrollRectXY.x;
				ScrollRectManager.scrollRectOffsetY -= this.scaledScrollRectXY.y;
				support.translateMatrix(-this.scrollRect.x, -this.scrollRect.y);
			}
			super.render(support, alpha);
			if(this.scrollRect) {
				support.finishQuadBatch();
				support.translateMatrix(this.scrollRect.x, this.scrollRect.y);
				ScrollRectManager.scrollRectOffsetX += this.scaledScrollRectXY.x;
				ScrollRectManager.scrollRectOffsetY += this.scaledScrollRectXY.y;
				ScrollRectManager.currentScissorRect = oldRect;
				Starling.context.setScissorRectangle(oldRect);
			}
		}
		
		override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject {
			if(this.scrollRect) {
				//make sure we're in the bounds of this sprite first
				if(this.getBounds(this, helpRect).containsPoint(localPoint)) {
					localPoint.x += this.scrollRect.x;
					localPoint.y += this.scrollRect.y;
					var result:DisplayObject = super.hitTest(localPoint, forTouch);
					localPoint.x -= this.scrollRect.x;
					localPoint.y -= this.scrollRect.y;
					return result;
				}
				return null;
			}
			return super.hitTest(localPoint, forTouch);
		}
		
		public function invalidate(flag:int = -1):void {
			this.invalidationFlag.setInvalid(flag);
			if(this.stage)
				validationQueue.addControl(this, false);
		}
		
		public function validate():void {
			draw();
			this.invalidationFlag.reset();
		}
		
		public function toString():String {
			return getQualifiedClassName(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function init():void {
			inited = true;
			validationQueue = ValidationQueue.getInstance();
			this.invalidate();
		}
		
		protected function draw():void {
			if (this.invalidationFlag.isSizeInvalid())
				resize();
			if (this.invalidationFlag.isDataInvalid())
				refreshData();
			if (this.invalidationFlag.isStateInvalid())
				refreshState();
			if (this.invalidationFlag.isStyleInvalid())
				refreshStyle();
			if (this.invalidationFlag.isTextInvalid())
				refreshText();
		}
		
		protected function refreshText():void {
			
		}
		
		protected function refreshStyle():void {
			
		}
		
		protected function refreshState():void {
			
		}
		
		protected function refreshData():void {
			
		}
		
		protected function resize():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		protected function onAddToStage(e:Event):void {
			if (e.target == this) { 
				removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
				this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
				
				if (!inited) {
					init();
				}
			}
		}
		
		protected function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
	}

}
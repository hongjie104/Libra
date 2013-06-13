package org.libra.ui.starling.core {
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.libra.ui.starling.managers.ScrollRectManager;
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.utils.MatrixUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Container
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class Container extends Component implements IDisplayObjectWithScrollRect, IDropable {
		
		private static var helpPoint:Point = new Point();
		private static var helpMatrix:Matrix = new Matrix();
		private static var helpRect:Rectangle = new Rectangle();
		
		protected var scrollRect:Rectangle;
		
		private var scaledScrollRectXY:Point;
		
		private var scissorRect:Rectangle;
		
		private var dropAcceptList:Vector.<IDragable>;
		
		public function Container(width:int, height:int, x:int = 0, y:int = 0) { 
			super(width, height, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function addChildAll(...rest):void {
			for each(var i:flash.display.DisplayObject in rest) {
				this.addChild(i);
			}
		}
		
		/**
		 * 将显示对象置于顶层显示
		 * @param	child 显示对象
		 */
		public function bringToTop(child:DisplayObject):void {
			if (this.contains(child)) {
				setChildIndex(child, this.numChildren - 1);	
			}
		}
		
		/**
		 * 将显示对象置于底层显示，如果设置了背景，
		 * 那么将显示对象置于背景的上一层，背景层永远在最底层
		 * @param	child 显示对象
		 */
		public function bringToBottom(child:DisplayObject):void {
			if (this.contains(child)) {
				var index:int = 0;
				if(background){
					if(background != child){
						index = 1;
					}
				}
				setChildIndex(child, index);
			}
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
		
		/* INTERFACE org.libra.ui.starling.core.IDropable */
		
		public function addDropAccept(dragable:IDragable):void {
			if (!dropAcceptList) dropAcceptList = new Vector.<IDragable>();
			if(this.dropAcceptList.indexOf(dragable) == -1)
				dropAcceptList.push(dragable);
		}
		
		public function removeDropAccept(dragable:IDragable):void {
			if (this.dropAcceptList) {
				var index:int = this.dropAcceptList.indexOf(dragEnabled);
				if (index != -1) this.dropAcceptList.splice(index, 1);
			}
		}
		
		public function isDropAccept(dragable:IDragable):Boolean {
			return this.dropAcceptList ? this.dropAcceptList.indexOf(dragable) != -1 : false;
		}
		
		public function addDragComponent(dragable:IDragable):void {
			//dragable.removeFromParent();
			//this.append(dragEnabled as Component);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
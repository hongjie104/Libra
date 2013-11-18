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
	 * 容器类
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
		
		private static var _helpPoint:Point = new Point();
		
		private static var _helpMatrix:Matrix = new Matrix();
		
		private static var _helpRect:Rectangle = new Rectangle();
		
		protected var _scrollRect:Rectangle;
		
		private var _scaledScrollRectXY:Point;
		
		private var _scissorRect:Rectangle;
		
		private var _dropAcceptList:Vector.<IDragable>;
		
		public function Container(width:int, height:int, x:int = 0, y:int = 0) { 
			super(width, height, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function addChildAll(...rest):void {
			for each(var i:DisplayObject in rest) {
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
				if(_background){
					if(_background != child){
						index = 1;
					}
				}
				setChildIndex(child, index);
			}
		}
		
		public function get scrollRect():Rectangle {
			return this._scrollRect;
		}
		
		public function set scrollRect(value:Rectangle):void {
			this._scrollRect = value;
			if (this._scrollRect) { 
				if(!this._scaledScrollRectXY) this._scaledScrollRectXY = new Point();
				if (!this._scissorRect) this._scissorRect = new Rectangle();
			}else { 
				this._scaledScrollRectXY = null;
				this._scissorRect = null;
			}
		}
		
		override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle {
			if (this._scrollRect) {
				if (!resultRect) resultRect = new Rectangle();
				if (targetSpace == this) { 
					resultRect.x = 0;
					resultRect.y = 0;
					resultRect.width = this._scrollRect.width;
					resultRect.height = this._scrollRect.height;
				}else { 
					this.getTransformationMatrix(targetSpace, _helpMatrix);
					MatrixUtil.transformCoords(_helpMatrix, 0, 0, _helpPoint);
					resultRect.x = _helpPoint.x;
					resultRect.y = _helpPoint.y;
					resultRect.width = _helpMatrix.a * this._scrollRect.width + _helpMatrix.c * this._scrollRect.height;
					resultRect.height = _helpMatrix.d * this._scrollRect.height + _helpMatrix.b * this._scrollRect.width;
				}
				return resultRect;
			}
			return super.getBounds(targetSpace, resultRect);
		}
		
		override public function render(support:RenderSupport, alpha:Number):void { 
			if (this._scrollRect) { 
				const scale:Number = Starling.contentScaleFactor;
				this.getBounds(this.stage, this._scissorRect);
				this._scissorRect.x *= scale;
				this._scissorRect.y *= scale;
				this._scissorRect.width *= scale;
				this._scissorRect.height *= scale;
				
				this.getTransformationMatrix(this.stage, _helpMatrix);
				this._scaledScrollRectXY.x = this._scrollRect.x * _helpMatrix.a;
				this._scaledScrollRectXY.y = this._scrollRect.y * _helpMatrix.d;
				
				const oldRect:Rectangle = ScrollRectManager.currentScissorRect;
				if (oldRect) { 
					this._scissorRect.x += ScrollRectManager.scrollRectOffsetX * scale;
					this._scissorRect.y += ScrollRectManager.scrollRectOffsetY * scale;
					this._scissorRect = this._scissorRect.intersection(oldRect);
				}
				//isEmpty() && <= 0 don't work here for some reason
				if(this._scissorRect.width < 1 || this._scissorRect.height < 1 ||
					this._scissorRect.x >= Starling.current.nativeStage.stageWidth ||
					this._scissorRect.y >= Starling.current.nativeStage.stageHeight ||
					(this._scissorRect.x + this._scissorRect.width) <= 0 ||
					(this._scissorRect.y + this._scissorRect.height) <= 0) { 
					return;
				}
				support.finishQuadBatch();
				Starling.context.setScissorRectangle(this._scissorRect);
				ScrollRectManager.currentScissorRect = this._scissorRect;
				ScrollRectManager.scrollRectOffsetX -= this._scaledScrollRectXY.x;
				ScrollRectManager.scrollRectOffsetY -= this._scaledScrollRectXY.y;
				support.translateMatrix(-this._scrollRect.x, -this._scrollRect.y);
			}
			super.render(support, alpha);
			if(this._scrollRect) {
				support.finishQuadBatch();
				support.translateMatrix(this._scrollRect.x, this._scrollRect.y);
				ScrollRectManager.scrollRectOffsetX += this._scaledScrollRectXY.x;
				ScrollRectManager.scrollRectOffsetY += this._scaledScrollRectXY.y;
				ScrollRectManager.currentScissorRect = oldRect;
				Starling.context.setScissorRectangle(oldRect);
			}
		}
		
		override public function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject {
			if(this._scrollRect) {
				//make sure we're in the bounds of this sprite first
				if(this.getBounds(this, _helpRect).containsPoint(localPoint)) {
					localPoint.x += this._scrollRect.x;
					localPoint.y += this._scrollRect.y;
					var result:DisplayObject = super.hitTest(localPoint, forTouch);
					localPoint.x -= this._scrollRect.x;
					localPoint.y -= this._scrollRect.y;
					return result;
				}
				return null;
			}
			return super.hitTest(localPoint, forTouch);
		}
		
		/* INTERFACE org.libra.ui.starling.core.IDropable */
		
		public function addDropAccept(dragable:IDragable):void {
			if (!_dropAcceptList) _dropAcceptList = new Vector.<IDragable>();
			if(this._dropAcceptList.indexOf(dragable) == -1)
				_dropAcceptList.push(dragable);
		}
		
		public function removeDropAccept(dragable:IDragable):void {
			if (this._dropAcceptList) {
				var index:int = this._dropAcceptList.indexOf(dragable);
				if (index != -1) this._dropAcceptList.splice(index, 1);
			}
		}
		
		public function isDropAccept(dragable:IDragable):Boolean {
			return this._dropAcceptList ? this._dropAcceptList.indexOf(dragable) != -1 : false;
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
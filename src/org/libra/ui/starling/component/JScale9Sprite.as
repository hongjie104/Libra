package org.libra.ui.starling.component {
	import flash.geom.Rectangle;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.starling.core.Component;
	import org.libra.ui.starling.textures.Scale9Texture;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JScale9Sprite
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class JScale9Sprite extends Component {
		
		private static var helperImage:Image;
		
		private var texture:Scale9Texture;
		
		private var textureScale:Number;
		
		private var batch:QuadBatch;
		
		public function JScale9Sprite(texture:Scale9Texture, x:int = 0, y:int = 0, textureScale:Number = 1) { 
			super(0, 0, x, y);
			this.texture = texture;
			this.textureScale = textureScale;
			this.quickHitAreaEnabled = true;
			this.readjustSize();
			
			this.batch = new QuadBatch();
			this.batch.touchable = false;
			this.setBackground(this.batch);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function settexture(value:Scale9Texture):void {
			if(this.texture == value) return;
			
			this.texture = value;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function setTextureScale(value:Number):void {
			if (this.textureScale == value) return;
			
			this.textureScale = value;
			invalidate(InvalidationFlag.SIZE);
		}
		
		/**
		 * 调整大小
		 */
		public function readjustSize():void {
			const frame:Rectangle = this.texture.frame;
			this.width = frame.width * this.textureScale;
			this.height = frame.height * this.textureScale;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function resize():void {
			refreshData();
		}
		
		override protected function refreshData():void {
			this.batch.reset();
			
			if(!helperImage) helperImage = new starling.display.Image(this.texture.getTopLeft());
			
			const frame:Rectangle = this.texture.frame;
			const grid:Rectangle = this.texture.getScale9Grid();
			const scaledLeftWidth:Number = grid.x * this.textureScale;
			const scaledTopHeight:Number = grid.y * this.textureScale;
			const scaledRightWidth:Number = (frame.width - grid.x - grid.width) * this.textureScale;
			const scaledBottomHeight:Number = (frame.height - grid.y - grid.height) * this.textureScale;
			const scaledCenterWidth:Number = this.width - scaledLeftWidth - scaledRightWidth;
			const scaledMiddleHeight:Number = this.height - scaledTopHeight - scaledBottomHeight;
			
			if(scaledTopHeight > 0) {
				helperImage.texture = this.texture.getTopLeft();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = scaledLeftWidth - helperImage.width;
				helperImage.y = scaledTopHeight - helperImage.height;
				if(scaledLeftWidth > 0)
					this.batch.addImage(helperImage);
				
				helperImage.texture = this.texture.getTopCenter();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = scaledLeftWidth;
				helperImage.y = scaledTopHeight - helperImage.height;
				helperImage.width = scaledCenterWidth;
				if(scaledCenterWidth > 0)
					this.batch.addImage(helperImage);
				
				helperImage.texture = this.texture.getTopRight();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = this.width - scaledRightWidth;
				helperImage.y = scaledTopHeight - helperImage.height;
				if(scaledRightWidth > 0)
					this.batch.addImage(helperImage);
			}
			
			if(scaledMiddleHeight > 0) {
				helperImage.texture = this.texture.getMiddleLeft();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = scaledLeftWidth - helperImage.width;
				helperImage.y = scaledTopHeight;
				helperImage.height = scaledMiddleHeight;
				if(scaledLeftWidth > 0)
					this.batch.addImage(helperImage);
				
				helperImage.texture = this.texture.getMiddleCenter();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = scaledLeftWidth;
				helperImage.y = scaledTopHeight;
				helperImage.width = scaledCenterWidth;
				helperImage.height = scaledMiddleHeight;
				if(scaledCenterWidth > 0)
					this.batch.addImage(helperImage);
				
				helperImage.texture = this.texture.getMiddleRight();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = this.width - scaledRightWidth;
				helperImage.y = scaledTopHeight;
				helperImage.height = scaledMiddleHeight;
				if(scaledRightWidth > 0)
					this.batch.addImage(helperImage);
			}
			
			if(scaledBottomHeight > 0) {
				helperImage.texture = this.texture.getBottomLeft();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = scaledLeftWidth - helperImage.width;
				helperImage.y = this.height - scaledBottomHeight;
				if(scaledLeftWidth > 0)
					this.batch.addImage(helperImage);
				
				helperImage.texture = this.texture.getBottomCenter();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = scaledLeftWidth;
				helperImage.y = this.height - scaledBottomHeight;
				helperImage.width = scaledCenterWidth;
				if(scaledCenterWidth > 0)
					this.batch.addImage(helperImage);
				
				helperImage.texture = this.texture.getBottomRight();
				helperImage.readjustSize();
				helperImage.scaleX = helperImage.scaleY = this.textureScale;
				helperImage.x = this.width - scaledRightWidth;
				helperImage.y = this.height - scaledBottomHeight;
				if(scaledRightWidth > 0)
					this.batch.addImage(helperImage);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
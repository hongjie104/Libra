package org.libra.ui.starling.component {
	import flash.geom.Rectangle;
	import org.libra.ui.Constants;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.starling.core.Component;
	import org.libra.ui.starling.textures.Scale3Texture;
	import starling.display.Image;
	import starling.display.QuadBatch;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JScale3Sprite
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class JScale3Sprite extends Component {
		
		private static var helperImage:Image;
		
		private var batch:QuadBatch;
		
		private var texture:Scale3Texture;
		
		private var textureScale:Number;
		
		public function JScale3Sprite(texture:Scale3Texture, x:int = 0, y:int = 0, textureScale:Number = 1) { 
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
		public function settexture(value:Scale3Texture):void {
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
			this.setSize(frame.width * this.textureScale, frame.height * this.textureScale);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function resize():void {
			refreshData();
		}
		
		override protected function refreshData():void {
			this.batch.reset();
			if(!helperImage) helperImage = new Image(this.texture.getFirstTexture());
			
			const frame:Rectangle = this.texture.frame;
			if (this.texture.getDirection() == Constants.VERTICAL) {
				var scaledOppositeEdgeSize:Number = this.actualWidth;
				var oppositeEdgeScale:Number = scaledOppositeEdgeSize / frame.width;
				var scaledFirstRegionSize:Number = this.texture.getFirstSize() * oppositeEdgeScale;
				var scaledThirdRegionSize:Number = (frame.height - this.texture.getFirstSize() - this.texture.getSecondSize()) * oppositeEdgeScale;
				var scaledSecondRegionSize:Number = this.height - scaledFirstRegionSize - scaledThirdRegionSize;
				
				if(scaledOppositeEdgeSize > 0) {
					helperImage.texture = this.texture.getFirstTexture();
					helperImage.readjustSize();
					helperImage.x = 0;
					helperImage.y = 0;
					helperImage.width = scaledOppositeEdgeSize;
					helperImage.height = scaledFirstRegionSize;
					if (scaledFirstRegionSize > 0)
						this.batch.addImage(helperImage);
					
					helperImage.texture = this.texture.getSecondTexture();
					helperImage.readjustSize();
					helperImage.x = 0;
					helperImage.y = scaledFirstRegionSize;
					helperImage.width = scaledOppositeEdgeSize;
					helperImage.height = scaledSecondRegionSize;
					if(scaledSecondRegionSize > 0)
						this.batch.addImage(helperImage);
					
					helperImage.texture = this.texture.getThirdTexture();
					helperImage.readjustSize();
					helperImage.x = 0;
					helperImage.y = this.height - scaledThirdRegionSize;
					helperImage.width = scaledOppositeEdgeSize;
					helperImage.height = scaledThirdRegionSize;
					if(scaledThirdRegionSize > 0)
						this.batch.addImage(helperImage);
				}
			}else {
				//horizontal
				scaledOppositeEdgeSize = this.height;
				oppositeEdgeScale = scaledOppositeEdgeSize / frame.height;
				scaledFirstRegionSize = this.texture.getFirstSize() * oppositeEdgeScale;
				scaledThirdRegionSize = (frame.width - this.texture.getFirstSize() - this.texture.getSecondSize()) * oppositeEdgeScale;
				scaledSecondRegionSize = this.width - scaledFirstRegionSize - scaledThirdRegionSize;
				
				if(scaledOppositeEdgeSize > 0) {
					helperImage.texture = this.texture.getFirstTexture();
					helperImage.readjustSize();
					helperImage.x = 0;
					helperImage.y = 0;
					helperImage.width = scaledFirstRegionSize;
					helperImage.height = scaledOppositeEdgeSize;
					if(scaledFirstRegionSize > 0)
						this.batch.addImage(helperImage);
					
					helperImage.texture = this.texture.getSecondTexture();
					helperImage.readjustSize();
					helperImage.x = scaledFirstRegionSize;
					helperImage.y = 0;
					helperImage.width = scaledSecondRegionSize;
					helperImage.height = scaledOppositeEdgeSize;
					if(scaledSecondRegionSize > 0)
						this.batch.addImage(helperImage);
					
					helperImage.texture = this.texture.getThirdTexture();
					helperImage.readjustSize();
					helperImage.x = this.width - scaledThirdRegionSize;
					helperImage.y = 0;
					helperImage.width = scaledThirdRegionSize;
					helperImage.height = scaledOppositeEdgeSize;
					if(scaledThirdRegionSize > 0)
						this.batch.addImage(helperImage);
				}
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
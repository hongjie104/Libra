package org.libra.ui.starling.textures {
	import flash.geom.Rectangle;
	import org.libra.ui.Constants;
	import starling.textures.Texture;
	/**
	 * <p>
	 * 三宫缩放纹理
	 * 上中下或者左中右
	 * </p>
	 *
	 * @class Scale3Texture
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class Scale3Texture {
		
		/**
		 * 纹理源
		 */
		private var texture:Texture;
		
		/**
		 * 缩放的第一个点到注册点的距离，单位：像素
		 */
		private var firstSize:int;
		
		/**
		 * 缩放的第二个点到注册点的距离，单位：像素
		 */
		private var secondSize:int;
		
		/**
		 * 缩放的方向。水平或者垂直
		 */
		private var direction:int;
		
		/**
		 * 第一宫的纹理
		 */
		private var firstTexture:Texture;
		
		/**
		 * 第二宫纹理
		 */
		private var secondTexture:Texture;
		
		/**
		 * 第三宫纹理
		 */
		private var thirdTexture:Texture;
		
		public function Scale3Texture(texture:Texture, firstSize:int, secondSize:int, direction:int = 0) { 
			this.texture = texture;
			this.firstSize = firstSize;
			this.secondSize = secondSize;
			this.direction = direction;
			
			const textureFrame:Rectangle = texture.frame;
			var thirdSize:int;
			thirdSize = (this.direction == Constants.HORIZONTAL ? textureFrame.width : textureFrame.height) - this.firstSize - this.secondSize;
			
			if(this.direction == Constants.VERTICAL) {
				const topHeight:int = this.firstSize + textureFrame.y;
				const bottomHeight:int = thirdSize - (textureFrame.height - texture.height) - textureFrame.y;
				
				var hasTopFrame:Boolean = topHeight != this.firstSize;
				var hasRightFrame:Boolean = (textureFrame.width - textureFrame.x) != texture.width;
				var hasBottomFrame:Boolean = bottomHeight != thirdSize;
				var hasLeftFrame:Boolean = textureFrame.x != 0;
				
				var firstRegion:Rectangle = new Rectangle(0, 0, texture.width, topHeight);
				var firstFrame:Rectangle = (hasLeftFrame || hasRightFrame || hasTopFrame) ? new Rectangle(textureFrame.x, textureFrame.y, textureFrame.width, this.firstSize) : null;
				this.firstTexture = Texture.fromTexture(texture, firstRegion, firstFrame);
				
				var secondRegion:Rectangle = new Rectangle(0, topHeight, texture.width, this.secondSize);
				var secondFrame:Rectangle = (hasLeftFrame || hasRightFrame) ? new Rectangle(textureFrame.x, 0, textureFrame.width, this.secondSize) : null;
				this.secondTexture = Texture.fromTexture(texture, secondRegion, secondFrame);
				
				var thirdRegion:Rectangle = new Rectangle(0, topHeight + this.secondSize, texture.width, bottomHeight);
				var thirdFrame:Rectangle = (hasLeftFrame || hasRightFrame || hasBottomFrame) ? new Rectangle(textureFrame.x, 0, textureFrame.width, thirdSize) : null;
				this.thirdTexture = Texture.fromTexture(texture, thirdRegion, thirdFrame);
			}else { 
				//horizontal
				const regionLeftWidth:int = this.firstSize + textureFrame.x;
				const regionRightWidth:int = thirdSize - (textureFrame.width - texture.width) - textureFrame.x;
				
				hasTopFrame = textureFrame.y != 0;
				hasRightFrame = regionRightWidth != thirdSize;
				hasBottomFrame = (textureFrame.height - textureFrame.y) != texture.height;
				hasLeftFrame = regionLeftWidth != this.firstSize;
				
				firstRegion = new Rectangle(0, 0, regionLeftWidth, texture.height);
				firstFrame = (hasLeftFrame || hasTopFrame || hasBottomFrame) ? new Rectangle(textureFrame.x, textureFrame.y, this.firstSize, textureFrame.height) : null;
				this.firstTexture = Texture.fromTexture(texture, firstRegion, firstFrame);
				
				secondRegion = new Rectangle(regionLeftWidth, 0, this.secondSize, texture.height);
				secondFrame = (hasTopFrame || hasBottomFrame) ? new Rectangle(0, textureFrame.y, this.secondSize, textureFrame.height) : null;
				this.secondTexture = Texture.fromTexture(texture, secondRegion, secondFrame);
				
				thirdRegion = new Rectangle(regionLeftWidth + this.secondSize, 0, regionRightWidth, texture.height);
				thirdFrame = (hasTopFrame || hasBottomFrame || hasRightFrame) ? new Rectangle(0, textureFrame.y, thirdSize, textureFrame.height) : null;
				this.thirdTexture = Texture.fromTexture(texture, thirdRegion, thirdFrame);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getFirstTexture():Texture {
			return this.firstTexture;
		}
		
		public function getSecondTexture():Texture {
			return this.secondTexture;
		}
		
		public function getThirdTexture():Texture {
			return this.thirdTexture;
		}
		
		public function getFirstSize():int {
			return this.firstSize;
		}
		
		public function getSecondSize():int {
			return this.secondSize;
		}
		
		public function get frame():Rectangle {
			return this.texture ? texture.frame : null;
		}
		
		public function getDirection():int {
			return this.direction;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
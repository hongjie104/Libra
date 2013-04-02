package org.libra.bmpEngine.multiTest {
	import flash.display.Bitmap;
	import org.libra.displayObject.JSprite;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JMultiBitmapTest
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/01/2013
	 * @version 1.0
	 * @see
	 */
	public class JMultiBitmapTest extends JSprite {
		
		protected var $totalFrame:int;
		
		protected var $frame:int;
		
		protected var $playing:Boolean;
		
		protected var baseBitmap:Bitmap;
		
		private var layerList:Vector.<RenderLayerTest>;
		
		public function JMultiBitmapTest() {
			super();
			baseBitmap = new Bitmap();
			this.addChild(baseBitmap);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function gotoAndPlay(frame:int):void {
			this.frame = frame;
			$playing = true;
		}
		
		public function set frame(val:int):void {
			if (this.$frame != val) {
				this.$frame = val;
			}
		}
		
		public function get playing():Boolean {
			return $playing;
		}
		
		public function set playing(val:Boolean):void {
			this.$playing = val;
		}
		
		public function render():void {
			/*var rebuild:Boolean = false;
                        
                        for each (var clayer:RenderLayer in layers)
                        {
                                clayer.render();
                                
                                if (clayer.hasUpdated())
                                {
                                        rebuild = true;
                                        continue;
                                }
                        }
                        
                        if (rebuild)
                        {
                                bitmapData.lock();
                                
                                if ( !hasBG )
                                {
                                        bitmapData.fillRect( rect, 0x0 );
                                }
                                
                                for each (var layer:RenderLayer in layers)
                                {
                                        bitmapData.copyPixels( layer.bitmapData, layer.rect, ZERO_POINT, null, null, true );
                                }
                                
                                bitmapData.unlock();
                        }*/
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
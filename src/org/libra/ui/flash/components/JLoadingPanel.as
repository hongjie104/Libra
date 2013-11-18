package org.libra.ui.flash.components {
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.managers.LayoutManager;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.ContainerSkin;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * 进度条面板
	 * </p>
	 *
	 * @class JLoadingPanel
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class JLoadingPanel extends JPanel {
		
		protected var _progressBar:JProgressBar;
		
		protected var _progress:Number;
		
		public function JLoadingPanel(owner:IContainer, skin:ContainerSkin = null, w:int = 300, h:int = 200) { 
			super(owner, w, h, '', true, skin ? skin : UIManager.instance.skin.panelSkin);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			_progressBar = new JProgressBar(0, 0, UIManager.instance.skin.progressBarSkin);
			this.append(_progressBar);
		}
		
		override public function show():void {
			if (showing) return;
			this._owner.append(this);
			_showing = true;
			LayoutManager.instance.addPanel(this);
		}
		
		public function set progress(val:Number):void {
			_progress = val;
			invalidate(InvalidationFlag.DATA);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function refreshData():void {
			_progressBar.progress = _progress;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
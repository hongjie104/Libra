package org.libra.ui.flash.components {
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.managers.LayoutManager;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultPanelTheme;
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
		
		protected var progressBar:JProgressBar;
		
		protected var progress:Number;
		
		public function JLoadingPanel(owner:IContainer, theme:DefaultPanelTheme = null, w:int = 300, h:int = 200) { 
			super(owner, theme ? theme : UIManager.getInstance().theme.panelTheme, w, h, '', true);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			progressBar = new JProgressBar(UIManager.getInstance().theme.progressBarTheme);
			this.append(progressBar);
		}
		
		override public function show():void {
			if (showing) return;
			this.owner.append(this);
			showing = true;
			LayoutManager.getInstance().addPanel(this);
		}
		
		public function setProgress(val:Number):void {
			progress = val;
			invalidate(InvalidationFlag.DATA);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function refreshData():void {
			progressBar.setProgress(progress);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
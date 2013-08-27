package org.libra.utils {
	import flash.net.LocalConnection;
	import flash.system.System;
	import org.libra.log4a.Logger;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class GC
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/29/2013
	 * @version 1.0
	 * @see
	 */
	public final class GC {
		
		public function GC() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		static public function gc():void {
			var val:int = System.totalMemory >> 20;
			Logger.info('当前内存:' + val + 'MB');
			try { 
				(new LocalConnection).connect("foo");
				(new LocalConnection).connect("foo");
			}catch (error:Error) { 
			} finally {
				var val1:int = System.totalMemory >> 20;
				Logger.info('GC后内存:' + val1 + 'MB,内存减小' + (val - val1) + 'MB');
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
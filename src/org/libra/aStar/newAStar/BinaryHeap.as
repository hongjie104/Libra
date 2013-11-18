package org.libra.aStar.newAStar {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BinaryHeap
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 10/17/2013
	 * @version 1.0
	 * @see
	 */
	public final class BinaryHeap {
		
		public var a:Array = [];
		public var justMinFun:Function = function(x:Object, y:Object):Boolean {
			return x < y;
		};
		
		public function BinaryHeap(justMinFun:Function = null){
			a.push(-1);
			if (justMinFun != null)
				this.justMinFun = justMinFun;
		}

		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function ins(value:Node):void {
			var p:int = a.length;
			a[p] = value;
			var pp:int = p >> 1;
			var temp:Node;
			while (p > 1 && justMinFun(a[p], a[pp])){
				temp = a[p];
				a[p] = a[pp];
				a[pp] = temp;
				p = pp;
				pp = p >> 1;
			}
		}

		public function pop():Node {
			var min:Node = a[1];
			a[1] = a[a.length - 1];
			a.pop();
			var p:int = 1;
			var l:int = a.length;
			var sp1:int = p << 1;
			var sp2:int = sp1 + 1;
			while (sp1 < l){
				if (sp2 < l){
					var minp:int = justMinFun(a[sp2], a[sp1]) ? sp2 : sp1;
				} else {
					minp = sp1;
				}
				if (justMinFun(a[minp], a[p])){
					var temp:Node = a[p];
					a[p] = a[minp];
					a[minp] = temp;
					p = minp;
					sp1 = p << 1;
					sp2 = sp1 + 1;
				} else {
					break;
				}
			}
			return min;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
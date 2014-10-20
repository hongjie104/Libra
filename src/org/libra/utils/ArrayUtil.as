package org.libra.utils
{
	public final class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		
		public static function rotate(ary:Array):Array{
			const m:int = ary.length;
			const n:int = ary[0].length;
			var result:Array = [];
			for(i = 0; i < n;i+=1){
				result[i] = [];
				for(j = 0;j < m;j+=1){
					result[i][j] = 0;
				}
			}
			for(var i:int = 0;i < m;i+=1){
				for(var j:int = 0;j < n;j+=1){
					//result[j][m - i - 1] = ary[i][j];
					result[j][i] = ary[i][j];
				}
			}
			return result;
		}
		
		public static function hasVal(ary:Array, val:*):Boolean{
			var i:int = ary.length;
			while(--i > -1){
				if(ary[i] == val) return true;
			}
			return false;
		}
	}
}
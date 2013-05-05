package org.libra.utils.maxRects
{
	public final class FreeRectangleChoiceHeuristic
	{
		
		public static const BestShortSideFit:int = 0; ///< -BSSF: Positions the Rectangle against the short side of a free Rectangle into which it fits the best.
		public static const BestLongSideFit:int = 1; ///< -BLSF: Positions the Rectangle against the long side of a free Rectangle into which it fits the best.
		public static const BestAreaFit:int = 2; ///< -BAF: Positions the Rectangle into the smallest free Rectangle into which it fits.
		public static const BottomLeftRule:int = 3; ///< -BL: Does the Tetris placement.
		public static const ContactPointRule:int = 4; ///< -CP: Choosest the placement where the Rectangle touches other Rectangles as much as possible.
		
		public function FreeRectangleChoiceHeuristic()
		{
		}
	}
}
package org.libra.utils {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class TweenUtil
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-06-2012
	 * @version 1.0
	 * @see
	 */
	public final class TweenUtil {
		
		public function TweenUtil() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
/*AS3动画效果公式,常用处理公式代码,基本运动公式,三角公式
?
as3种常见的弹性效果公式以及波形运动等as3动画效果公式代码整理，对于常用的来说作者整理的很全面，包括AS3的进制转换颜色提取等效果：

AS3缓动公式:
sprite.x += (targetX – sprite.x) * easing;//easing为缓动系数变量
sprite.y += (targetY – sprite.y) * easing;

AS3弹性公式:
vx += (targetX – sprite.x) * spring;//spring为弹性系数
vy += (targetY – sprite.y) * spring;
sprite.x += (vx *= friction);//friction为摩擦力
sprite.y += (vy *= friction);

AS3偏移弹性公式:
var dx:Number = sprite.x – fixedX;
var dy:Number = sprite.y – fixedY;
var angle:Number = Math.atan2(dy, dx);
var targetX:Number = fixedX + Math.cos(angle) * springLength;
var targetY:Number = fixedX + Math.sin(angle) * springLength;

AS3向鼠标旋转(或向某点旋转)
dx = mouseX – sprite.x;
dy = mouseY – sprite.y;
sprite.rotation = Math.atan2(dy, dx) * 180 / Math.PI;

AS3波形运动:
public function onEnterFrame1(event:Event):void {
ball.y=centerScale+Math.sin(angle)*range;
angle+=speed;
}

心跳:
public function onEnterFrame1(event:Event):void {
ball.scaleX=centerScale+Math.sin(angle)*range;
ball.scaleY=centerScale+Math.sin(angle)*range;
angle+=speed;
}
AS3圆心旋转:
public function onEnterFrame(event:Event):void {
ball.x=centerX+Math.cos(angle)*radius;
ball.y=centerY+Math.sin(angle)*radius;
angle+=speed;
}

椭圆旋转:
public function onEnterFrame(event:Event):void {
ball.x=centerX+Math.cos(angle)*radiusX;
ball.y=centerY+Math.sin(angle)*radiusY;
angle+=speed;
}
AS3颜色运算得到透明值:
var t:uint=0×77ff8877
var s:uint=0xff000000
var h:uint=t&s
var m:uint=h>>>24
trace(m)
AS3转换为十进制:
trace(hexValue);
AS3十进制转换为十六进制:
decimalValue.toString(16)
AS3颜色提取:
red = color24 >> 16;
green = color24 >> 8 & 0xFF;
blue = color24 & 0xFF;
alpha = color32 >> 24;
red = color32 >> 16 & 0xFF;
green = color32 >> 8 & 0xFF;
blue = color232 & 0xFF;
AS3按位计算得到颜色值:
color24 = red < < 16 | green << 8 | blue;
color32 = alpha << 24 | red << 16 | green << 8 | blue;
AS3过控制点的曲线:
// xt, yt is the point you want to draw through
// x0, y0 and x2, y2 are the end points of the curve
x1 = xt * 2 – (x0 + x2) / 2;
y1 = yt * 2 – (y0 + y2) / 2;
moveTo(x0, y0);
curveTo(x1, y1, x2, y2);*/

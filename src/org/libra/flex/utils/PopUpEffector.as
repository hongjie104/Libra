package org.libra.flex.utils {
	import flash.geom.Matrix;

	import mx.core.IFlexDisplayObject;
	import mx.effects.Blur;
	import mx.events.EffectEvent;
	import mx.managers.PopUpManager;

	import spark.effects.Fade;
	import spark.effects.Scale;
	import spark.effects.easing.Bounce;

	/**
	 * @name PopUpEffector
	 * @arguments 生成动画，应用于窗口
	 * @author MoLice
	 *
	 * @private {IFlexDisplayObject} win 保存构造函数接收的窗口对象
	 * @private {Object} effector 保存动画Effect对象
	 * @private {Number} duration 设置动画持续时间
	 *
	 * @private {void} blur_show() 模糊效果弹出
	 * @private {void} blur_hide() 模糊效果关闭
	 * @private {void} fade_show() 渐变效果弹出
	 * @private {void} fade_hide() 渐变效果关闭
	 * @private {void} bubble_show() 冒泡效果弹出
	 * @private {void} bubble_hide{} 冒泡效果关闭
	 * @public {void} play() 调用方法，应用动画
	 */
	public class PopUpEffector {
		private var win:IFlexDisplayObject;
		private var effector:Object;
		private var duration:Number;

		/**
		 * @construct
		 * @arugments 接收参数，选择要使用的动画类型
		 * @param {IFlexDisplayObject} win 保存构造函数接收的窗口对象
		 * @param {Boolean} isShow true表示弹出，false表示关闭
		 * @param {Number|String} type 使用的动画类型。使用数字是因为可以利用随机数，让弹出效果随机化
		 *          |- 0            默认，无动画
		 *          |- 1 | "blur"   模糊
		 *          |- 2 | "fade"   渐变
		 *          |- 3 | "bubble" 冒泡
		 * @param {Number} duration 动画执行时间，默认300
		 */
		public function PopUpEffector(win:IFlexDisplayObject, isShow:Boolean, type:*, duration:Number=300) {
			this.win=win;
			this.duration=duration;

			if (isShow) {
				//出现
				switch (type) {
					case 0:
						break;
					case 1:
					case "blur":
						blur_show();
						break;
					case 2:
					case "fade":
						fade_show();
						break;
					case 3:
					case "bubble":
						bubble_show();
						break;
					default:
						break;
				}
			} else {
				//消失
				switch (type) {
					case 0:
						break;
					case 1:
					case "blur":
						blur_hide();
						break;
					case 2:
					case "fade":
						fade_hide();
						break;
					case 3:
					case "bubble":
						bubble_hide();
						break;
					default:
						PopUpManager.removePopUp(this.win);
						break;
				}
				
				if(this.effector){
					this.effector.addEventListener(EffectEvent.EFFECT_END, function(e:EffectEvent):void {
						PopUpManager.removePopUp(e.effectInstance.target as IFlexDisplayObject);
						//恢复滤镜造成的效果，否则show和hide的动画方式不一样的话，关闭窗口后还是会影响下次显示
						e.effectInstance.target.filters=[];
						//恢复半透明
						e.effectInstance.target.alpha=1;
					});
				}
			}
			
			if(this.effector){
				this.effector.duration=this.duration;
				this.effector.target=this.win;
			}
		}

		//外部调用方法
		public function play():void {
			//如果是0或default，则没有为effecter赋值，所以不用调用play()
			this.effector && (this.effector.end(), this.effector.play());
		}

		//模糊
		private function blur_show():void {
			this.effector=new Blur();
			this.effector.blurXFrom=255;
			this.effector.blurYFrom=255;
			this.effector.blurXTo=0;
			this.effector.blurYTo=0;
		}

		private function blur_hide():void {
			this.effector=new Blur();
			this.effector.blurXFrom=0;
			this.effector.blurYFrom=0;
			this.effector.blurXTo=255;
			this.effector.blurYTo=255;
		}

		//淡出淡入
		private function fade_show():void {
			this.effector=new Fade();
			this.effector.alphaFrom=0.0;
			this.effector.alphaTo=1.0;
		}

		private function fade_hide():void {
			this.effector=new Fade();
			this.effector.alphaFrom=1.0;
			this.effector.alphaTo=0.0;
		}

		//冒泡
		private function bubble_show():void {
			this.effector=new Scale();
			//恢复默认transform
			this.win.transform.matrix=new Matrix();
			this.effector.scaleXFrom=0;
			this.effector.scaleYFrom=0;
			this.effector.scaleXTo=1;
			this.effector.scaleYTo=1;
			this.effector.easer=new Bounce();
			this.effector.autoCenterTransform=true;
		}

		private function bubble_hide():void {
			this.effector=new Scale();
			this.effector.scaleXFrom=1;
			this.effector.scaleYFrom=1;
			this.effector.scaleXTo=0;
			this.effector.scaleYTo=0;
			this.effector.autoCenterTransform=true;
		}
	}
}

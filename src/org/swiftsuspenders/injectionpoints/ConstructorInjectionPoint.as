/*
 * Copyright (c) 2009 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders.injectionpoints
{
	import flash.utils.describeType;

	import org.swiftsuspenders.Injector;
	/**
	 * 构造函数注入点，扩展自MethodInjectionPoint
	 * */
	public class ConstructorInjectionPoint extends MethodInjectionPoint
	{
		/*******************************************************************************************
		*								public methods											   *
		*******************************************************************************************/
		public function ConstructorInjectionPoint(
				node : XML, clazz : Class, injector : Injector = null)
		{
			/*
			  In many cases, the flash player doesn't give us type information for constructors until 
			  the class has been instantiated at least once. Therefore, we do just that if we don't get 
			  type information for at least one parameter.
			 */ 
			/**
			 * 在许多情况下，Flash player在一个类至少被实例化一次之前不会给出type信息。因此我们先假装实例一下从而来获得类型信息
			 * */
			if (node.parameter.(@type == '*').length() == node.parameter.@type.length())//如果所有的参数类型都是*
			{
				createDummyInstance(node, clazz);//调用createDummyInstance函数，以解决FP的bug
			}
			super(node, injector);
		}
		
		override public function applyInjection(target : Object, injector : Injector) : Object
		{
			var ctor : Class = Class(target);//target是一个Class
			var p : Array = gatherParameterValues(target, injector);//获得构造函数的参数的值，调用父类方法
			//the only way to implement ctor injections, really!
			/**
			 * 唯一实现构造函数注入的方法，所以只能少于10个参数的构造函数
			 * */
			switch (p.length)
			{
				case 0 : return (new ctor());
				case 1 : return (new ctor(p[0]));
				case 2 : return (new ctor(p[0], p[1]));
				case 3 : return (new ctor(p[0], p[1], p[2]));
				case 4 : return (new ctor(p[0], p[1], p[2], p[3]));
				case 5 : return (new ctor(p[0], p[1], p[2], p[3], p[4]));
				case 6 : return (new ctor(p[0], p[1], p[2], p[3], p[4], p[5]));
				case 7 : return (new ctor(p[0], p[1], p[2], p[3], p[4], p[5], p[6]));
				case 8 : return (new ctor(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]));
				case 9 : return (new ctor(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]));
				case 10 : return (new ctor(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9]));
			}
			return null;
		}

		/*******************************************************************************************
		*								protected methods										   *
		*******************************************************************************************/
		override protected function initializeInjection(node : XML) : void
		{
			var nameArgs : XMLList = node.parent().metadata.(@name == 'Inject').arg.(@key == 'name');//获得包含参数的子节点
			methodName = 'constructor';//将方法名赋值为constructor,其实不赋值也没关系，因为构造函数输入用不到这个熟悉
			
			gatherParameters(node, nameArgs);//获取要注入的参数名
		}
		
		/*******************************************************************************************
		*								private methods											   *
		*******************************************************************************************/
		/**
		 * 为了防止无法获得构造函数的type信息，从而
		 * */
		private function createDummyInstance(constructorNode : XML, clazz : Class) : void
		{
			try//尝试new一下这个类，如果不行则抛出异常
			{
				switch (constructorNode.children().length())
				{
					case 0 : (new clazz()); break;
					case 1 : (new clazz(null)); break;
					case 2 : (new clazz(null, null)); break;
					case 3 : (new clazz(null, null, null)); break;
					case 4 : (new clazz(null, null, null, null)); break;
					case 5 : (new clazz(null, null, null, null, null)); break;
					case 6 : (new clazz(null, null, null, null, null, null)); break;
					case 7 : (new clazz(null, null, null, null, null, null, null)); break;
					case 8 : (new clazz(null, null, null, null, null, null, null, null)); break;
					case 9 : (new clazz(null, null, null, null, null, null, null, null, null)); break;
					case 10 : (new clazz(null, null, null, null, null, null, null, null, null, null)); break;
				}
			}
			catch (error : Error)
			{
				trace('Exception caught while trying to create dummy instance for constructor ' +
						'injection. It\'s almost certainly ok to ignore this exception, but you ' +
						'might want to restructure your constructor to prevent errors from ' +
						'happening. See the SwiftSuspenders documentation for more details. ' +
						'The caught exception was:\n' + error);
			}//在new完之后，不论是否new成功，类的xml描述就可以获得了
			constructorNode.setChildren(describeType(clazz).factory.constructor[0].children());//重新设置XML信息
		}
	}
}
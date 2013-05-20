/*
* Copyright (c) 2009 the original author or authors
* 
* Permission is hereby granted to use, modify, and distribute this file 
* in accordance with the terms of the license agreement accompanying it.
*/

package org.swiftsuspenders.injectionpoints
{
	import org.swiftsuspenders.Injector;
	
	/**
	 * 实际不是注入点，通过配置PostConstructInjectionPoint，可以再完成注入后执行相应的函数，order代表执行顺序顺序
	 * 如
	 	[PostConstruct(order="2")]
		public function post2():void{
			trace("post2");
		}
		[PostConstruct(order="1")]
		public function post1():void{
			trace("post1");
		}
		 * 当类中有这两个函数时
		 * 在该类完成注入时
		 * 就会先执行post1,再执行post2
		 * order决定了执行顺序
	 * */
	public class PostConstructInjectionPoint extends InjectionPoint
	{
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		protected var methodName : String;//方法名
		protected var orderValue:int;//顺序
		
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function PostConstructInjectionPoint(node:XML, injector : Injector = null)
		{
			super(node, injector);
		}
		
		public function get order():int
		{
			return orderValue;
		}

		override public function applyInjection(target : Object, injector : Injector) : Object
		{
			target[methodName]();//调用target的methodName方法
			return target;
		}
		
		
		/*******************************************************************************************
		 *								protected methods										   *
		 *******************************************************************************************/
		override protected function initializeInjection(node : XML) : void
		{
			var orderArg : XMLList = node.arg.(@key == 'order');//获取key是order节点
			var methodNode : XML = node.parent();//获取PostConstruct XML节点
			orderValue = int(orderArg.@value);//orderArg的value属性赋值给orderValue
			methodName = methodNode.@name.toString();//节点的name属性赋值给method，方法名
		}
	}
}
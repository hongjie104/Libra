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
	 * 注入点父类，抽象类，传入xml和Injector对象，调用initializeInjection钩子方法，采用模板方法
	 * */
	public class InjectionPoint
	{
		/*******************************************************************************************
		*								public methods											   *
		*******************************************************************************************/
		public function InjectionPoint(node : XML, injector : Injector)
		{	
			initializeInjection(node);
		}
		/**
		 * 抽象应用注入方发
		 * @param target - 注入目标
		 * @param injector - 注入器对象
		 * @return target 返回结果
		 * */
		public function applyInjection(target : Object, injector : Injector) : Object
		{
			return target;//返回注入目标
		}


		/*******************************************************************************************
		*								protected methods										   *
		*******************************************************************************************/
		/**
		 * 抽象钩子方法，由子类实现,以一个带有注入信息的xml作为参数
		 * */
		protected function initializeInjection(node : XML) : void
		{
		}
	}
}
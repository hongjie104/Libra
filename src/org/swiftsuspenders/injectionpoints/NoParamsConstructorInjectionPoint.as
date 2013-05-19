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
	 * 无参数的构造函数注入点
	 * */
	public class NoParamsConstructorInjectionPoint extends InjectionPoint
	{
		public function NoParamsConstructorInjectionPoint()
		{
			super(null, null);
		}
		
		override public function applyInjection(target : Object, injector : Injector) : Object
		{
			return new (target as Class)();//直接new
		}
	}
}
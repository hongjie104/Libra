/*
 * Copyright (c) 2010 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders
{
	import flash.utils.Proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	//
	internal function getConstructor(value : Object) : Class
	{
		/*
		   There are several types for which the 'constructor' property doesn't work:
		    - instances of Proxy, XML and XMLList throw exceptions when trying to access 'constructor'
		    - int and uint return Number as their constructor
		   For these, we have to fall back to more verbose ways of getting the constructor.

		   Additionally, Vector instances always return Vector.<*> when queried for their constructor.
		   Ideally, that would also be resolved, but the SwiftSuspenders wouldn't be compatible with
		   Flash Player < 10, anymore.
		 */
		/**
		有一些类constructor属性不工作
		- Proxy,XML,XMLList会在调用constructor属性时抛出异常
		- int,unit返回Number作为他们的constructor
		对于这些，我们需要特殊处理
		
		额外的，Vector对总是返回Vector.<*>
		*/
		if (value is Proxy || value is Number || value is XML || value is XMLList)
		{
			var fqcn : String = getQualifiedClassName(value);
			return Class(getDefinitionByName(fqcn));
		}
		return value.constructor;
	}
}
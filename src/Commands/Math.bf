namespace Automate.Commands;
using System;
class Math
{
	public static void Add(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				au.Stack.Push(Variant.Create(one.Get<double>() + two.Get<double>()));
			}
			else
				au.ThrowError("Cannot add non numbers");
		}
		else
			au.ThrowError("Cannot add non numbers");
	}

	public static void Sub(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				au.Stack.Push(Variant.Create(two.Get<double>() - one.Get<double>() ));
			}
			else
				au.ThrowError("Cannot sub non numbers");
		}
		else
			au.ThrowError("Cannot sub non numbers");
	}

	public static void Mult(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				au.Stack.Push(Variant.Create(two.Get<double>() * one.Get<double>() ));
			}
			else
				au.ThrowError("Cannot mult non numbers");
		}
		else
			au.ThrowError("Cannot mult non numbers");
	}

	public static void Div(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			if(one.Get<double>() == 0)
				au.ThrowError("Cannot divide by 0");
			else
			{
				var two = au.Stack.Pop!();
				if(two.HasValue && two.VariantType == typeof(double))
				{
					au.Stack.Push(Variant.Create(two.Get<double>() / one.Get<double>() ));
				}
				else
					au.ThrowError("Cannot sub non numbers");
			}
		}
		else
			au.ThrowError("Cannot sub non numbers");
	}
}
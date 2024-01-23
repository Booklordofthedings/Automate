namespace Automate.Commands;
using System;
class Comparisons
{
	public static void LessThan(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				if(two.Get<double>() < one.Get<double>())
					au.Stack.Push(Variant.Create(true));
				else
					au.Stack.Push(Variant.Create(false));
			}
			else
				au.ThrowError("Cannot compare non numbers");
		}
		else
			au.ThrowError("Cannot compare non numbers");
	}

	public static void GreaterThan(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				if(two.Get<double>() > one.Get<double>())
					au.Stack.Push(Variant.Create(true));
				else
					au.Stack.Push(Variant.Create(false));
			}
			else
				au.ThrowError("Cannot compare non numbers");
		}
		else
			au.ThrowError("Cannot compare non numbers");
	}

	public static void LessThanEquals(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				if(two.Get<double>() <= one.Get<double>())
					au.Stack.Push(Variant.Create(true));
				else
					au.Stack.Push(Variant.Create(false));
			}
			else
				au.ThrowError("Cannot compare non numbers");
		}
		else
			au.ThrowError("Cannot compare non numbers");
	}

	public static void GreaterThanEquals(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				if(two.Get<double>() >= one.Get<double>())
					au.Stack.Push(Variant.Create(true));
				else
					au.Stack.Push(Variant.Create(false));
			}
			else
				au.ThrowError("Cannot compare non numbers");
		}
		else
			au.ThrowError("Cannot compare non numbers");
	}

	public static void Equals(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				if(two.Get<double>() == one.Get<double>())
					au.Stack.Push(Variant.Create(true));
				else
					au.Stack.Push(Variant.Create(false));
			}
			else
				au.ThrowError("Cannot compare non numbers");
		}
		else
			au.ThrowError("Cannot compare non numbers");
	}
}
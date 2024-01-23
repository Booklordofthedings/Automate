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

	public static void Root(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			au.Stack.Push(Variant.Create(System.Math.Sqrt(one.Get<double>())));
		}
		else
			au.ThrowError("Cannot take the root of a non numerical value");
	}

	public static void Square(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var val = one.Get<double>();
			au.Stack.Push(Variant.Create(val * val));
		}
		else
			au.ThrowError("Cannot square non number");
	}

	public static void Cube(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var val = one.Get<double>();
			au.Stack.Push(Variant.Create(val * val * val));
		}
		else
			au.ThrowError("Cannot cube non number");
	}

	public static void Pi(Automate au)
	{
		au.Stack.Push(Variant.Create(System.Math.PI_d));
	}


	public static void Modulo(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				au.Stack.Push(Variant.Create(two.Get<double>() % one.Get<double>()));
			}
			else
				au.ThrowError("Cannot calculate the modulo of a non number");
		}
		else
			au.ThrowError("Cannot calculate the modulo of a non number");
	}

	public static void Pow(Automate au)
	{
		var one = au.Stack.Pop!();
		if(one.HasValue && one.VariantType == typeof(double))
		{
			var two = au.Stack.Pop!();
			if(two.HasValue && two.VariantType == typeof(double))
			{
				au.Stack.Push(Variant.Create(System.Math.Pow(two.Get<double>(), one.Get<double>())));
			}
			else
				au.ThrowError("Cannot take power of non number");
		}
		else
			au.ThrowError("Cannot take power of non number");
	}

	public static void Round(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
		{
			au.Stack.Push(Variant.Create(System.Math.Round(obj.Get<double>(),0)));
		}
		else
			au.ThrowError("Cannot round a non number");
	}

	public static void RoundFin(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
		{
			au.Stack.Push(Variant.Create(System.Math.Round(obj.Get<double>(),0,.AwayFromZero)));

		}
		else
			au.ThrowError("Cannot round a non number");
	}
}
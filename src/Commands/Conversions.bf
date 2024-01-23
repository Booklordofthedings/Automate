namespace Automate.Commands;
using System;
class Conversions
{
	public static void StringToNum(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(String))
		{
			var res = double.Parse(obj.Get<String>());
			if(res case .Ok(let val))
				au.Stack.Push(Variant.Create(val));
			else
				au.ThrowError("The string is not a parseable number");
		}
		else
			au.ThrowError("Cannot convert to number, since the object is no string");
	}

	public static void NumToString(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
			au.Stack.Push(Variant.Create(obj.Get<double>().ToString(.. new .()), true));
		else
			au.ThrowError("Cannot convert to string, since the object is no number");
	}

	public static void StringToBool(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(String))
		{
			var res = bool.Parse(obj.Get<String>());
			if(res case .Ok(let val))
			{
			  au.Stack.Push(Variant.Create(val));
			}
			else
				au.ThrowError("Couldnt parse the string to a boolean");
		}
		else
			au.ThrowError("Cannot convert something that isnt a string to a bool");
	}

	public static void BoolToString(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(bool))
			au.Stack.Push(Variant.Create<String>(obj.Get<bool>().ToString(.. new .()),true));
		else
			au.ThrowError("Not a bool");
	}
}
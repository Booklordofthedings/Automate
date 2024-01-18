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
				au.ThrowError("The String is not a parseable number");
		}
		else
			au.ThrowError("Cannot convert to Number, since the object is no String");

	}

	public static void NumToString(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
			au.Stack.Push(Variant.Create(obj.Get<double>().ToString(.. new .()), true));
		else
			au.ThrowError("Cannot convert to String, since the object is no number");
	}
}
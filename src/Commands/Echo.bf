namespace Automate.Commands;
using System;
using System.IO;
class Echo
{
	public static void Echo(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(String))
		{
			au.ConsoleCallback(obj.Get<String>());
		}
		else
			au.ThrowError("Cannot echo non String object");
	}

	public static void Print(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(String))
		{
			String text = scope .();
			var res = File.ReadAllText(obj.Get<String>(),text);
			if(res case .Ok)
			{
				au.ConsoleCallback(text);
			}
			else
				au.ThrowError(scope $"Could not read from file: {obj.Get<String>()}");
		}
		else
			au.ThrowError("Cannot print non String object");
	}
}
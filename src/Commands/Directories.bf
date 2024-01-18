namespace Automate.Commands;
using System;
using System.IO;
class Directories
{
	public static void MakeDirectory(Automate au)
	{
		var loc = au.Stack.Pop!();
		if(loc.HasValue && loc.VariantType == typeof(String))
		{
			var res = Directory.CreateDirectory(loc.Get<String>());
			if(res case .Err)
				au.ThrowError(scope $"Could not create directory at {loc.Get<String>()}");
		}
		else
			au.ThrowError("Input parameter for makedir is not a string");
	}
}
namespace Automate.Commands;
using System;
using System.IO;
class Files
{
	public static void MakeFile(Automate au)
	{
		var loc = au.Stack.Pop!();
		if(loc.HasValue && loc.VariantType == typeof(String))
		{
			if(!File.Exists(loc.Get<String>()))
			{
				var res = File.WriteAllText(loc.Get<String>(),"");
				if(res case .Err)
					au.ThrowError(scope $"Could not create file at {loc.Get<String>()}");
			}
			else
				au.ThrowError("The file that is supposed to be created already exists");
		}
		else
			au.ThrowError("Input parameter for makefile is not a string");
	}

	public static void DeleteFile(Automate au)
	{
		var loc = au.Stack.Pop!();
		if(loc.HasValue && loc.VariantType == typeof(String))
		{

		}
		else
			au.ThrowError("Input parameter for deletefile is not a string");
	}
}
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
			if(File.Exists(loc.Get<String>()))
			{
				var res = File.Delete(loc.Get<String>());
				if(res case .Err)
					au.ThrowError( scope $"Could not delete file with the name: {loc.Get<String>()}");
			}
			else
				au.ThrowError("Cannot delete a file that doesnt exist");
		}
		else
			au.ThrowError("Input parameter for deletefile is not a string");
	}

	public static void CopyFile(Automate au)
	{
		var dest = au.Stack.Pop!();
		if(dest.HasValue && dest.VariantType == typeof(String))
		{
			var target = au.Stack.Pop!();
			if(target.HasValue && target.VariantType == typeof(String) && File.Exists(target.Get<String>()))
			{
				File.Copy(target.Get<String>(),dest.Get<String>())
					.IgnoreError();
			}
			else
				au.ThrowError("Invalid target file");
		}
		else
			au.ThrowError("Destination is not a string or unavailable");
	}
}
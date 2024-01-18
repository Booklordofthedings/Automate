namespace Automate;
using System;
using System.IO;
class Program
{
	public static void Main(String[] args)
	{
		if(args.Count < 1)
		{
			Console.WriteLine("""
				Automate - A stack based scripting language thingy
				--------------------------------------------------
				Version: 1.0
				Author: Booklordofthedings
				Source Repository: https://Github.com/Booklordofthedings/automate
				--------------------------------------------------
				This is the compiled tool, to use it,
				simply pass the executeable a path to a readable
				automate script.
				A list of all valid commands is avilable in the source repo.
				""");
			return;
		}	
		String text = new .();
		defer delete text;
		var res = File.ReadAllText(args[0],text);
		if(res case .Err)
		{
			Console.WriteLine("Automate: Could not read the file to execute. Maybe it doesnt exist or you dont have acess rights.");
			return;
		}

		Automate o = new .();
		o.Instructions.LoadCode(text);
		o.Run();
		delete o;
	}
}
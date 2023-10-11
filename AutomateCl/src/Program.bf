namespace AutomateCl;
using LybCL;
using System;
using Automate;
using System.IO;
using Automate.Types;
using Automate.Machine;
using Automate.Commands;
class Program
{
	public static void Main(String[] args)
	{
		CommandLine cl = scope .(args);
		switch(cl.getCommand())
		{
		case "Default":
			fallthrough;
		case "help":
			fallthrough;
		case "Help":
			scope Help(cl);
			return;
		}
		//Any other command
		String path = null;
		if(File.Exists(cl.getCommand()) && path == null)
			path = new .(cl.getCommand());

		String temp = scope .(cl.getCommand());
		temp.Append(".automate");
		if(File.Exists(temp) && path == null)
			path = new .(temp);

		temp = scope .(Environment.GetExecutableFilePath(.. scope .()));
		temp.Append(scope $"scripts/{cl.getCommand()}");
		if(File.Exists(temp) && path == null)
			path = new .(temp);

		temp.Append(".automate");
		if(File.Exists(temp) && path == null)
			path = new .(temp);


		if(path == null)
		{
			Console.WriteLine("[Automate]: Unable to find script with that name");
			return;
		}

		String data = scope .();
		var res = File.ReadAllText(path, data);
		delete path;
		if(res case .Err)
		{
			Console.WriteLine("[Automate]: Unable to read file");
			return;
		}


		AutomateRunner runner = new AutomateRunner();
		//Register shit here
#region registerCommands
		runner.RegisterFunction("echo", => Echo.Echo);
#endregion
#region registerTypes
		runner.RegisterType("string", => Automate.Types.string.Parse);
#endregion

		var result = runner.RunUnoptimized(data);
		if(result case .Err(let err))
		{
			Console.WriteLine(err);
		}
		delete runner;
	}
}
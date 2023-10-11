namespace AutomateCl;
using LybCL;
using System;
class Help
{
	public this(CommandLine pCommands)
	{
		Console.WriteLine(scope $"""
			               _                        _       
			    /\\        | |                      | |      
			   /  \\  _   _| |_ ___  _ __ ___   __ _| |_ ___ 
			  / /\\ \\| | | | __/ _ \\| '_ ` _ \\ / _` | __/ _ \\
			 / ____ \\ |_| | || (_) | | | | | | (_| | ||  __/
			/_/    \\_\\__,_|\\__\\___/|_| |_| |_|\\__,_|\\__\\___|
			-------------------------------------------------------
			An automation scripting tool by Jannis - Booklordofthedings
			Version: {Automate.Automate.VERSION_MAJOR}.{Automate.Automate.VERSION_MINOR}.{Automate.Automate.VERSION_PATCH}
			BuildDate: {Compiler.TimeLocal}

			If your parameter is a file itll run it.
			It will also run scripts by name if they are next to the executeable in a scripts folder.
			""");
	}
}
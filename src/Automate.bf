namespace Automate;
using Automate.Commands;
using System;
using System.Collections;
class Automate
{
	public AutomateStack Stack = new .() ~ delete _;
	public AutomateInstructions Instructions = new .() ~ delete _;
	public function void(StringView) ConsoleCallback = => Console.WriteLine;

	private Dictionary<StringView, function void(Automate)> Commands = new .(100) ~ delete _;
	private bool shouldRun = true;

	public this()
	{
		///Register the default commands that automate is using

		//Conversions
		Commands.Add("stringToNum", => Conversions.StringToNum);
		Commands.Add("numToString", => Conversions.NumToString);

		//Math
		Commands.Add("add", => Automate.Commands.Math.Add);
		Commands.Add("sub", => Automate.Commands.Math.Sub);
		Commands.Add("mult", => Automate.Commands.Math.Mult);
		Commands.Add("div", => Automate.Commands.Math.Div);

		//IO
		Commands.Add("mkf", => Files.MakeFile);
		Commands.Add("mkd", => Directories.MakeDirectory);

		Commands.Add("echo", => Echo.Echo);
		Commands.Add("print", => Echo.Print);
	}

	public void ThrowError(StringView error)
	{
		ConsoleCallback(scope $"Error on line {Instructions.GetProgramCounter()} -> {Instructions.[Friend]_Instructions[Instructions.GetProgramCounter()-1]}: {error}");
		shouldRun = false;
	}

	///Run the previously loaded code
	public void Run()
	{
		shouldRun = true;
		while(shouldRun)
		{
			var line = Instructions.GetNextCommand();
			if(line == "exit")
				shouldRun = false;
			else if(line == "")
				continue;
			else if(line.StartsWith('>'))
				Stack.Push(Variant.Create<String>(new .(line, 1), true));
			else if(line.StartsWith('<'))
				Stack.Push(Variant.Create<double>(Instructions.[Friend]_Literals[line]));
			else if(line.StartsWith('#') || line.StartsWith('$'))
				continue;
			else if(!Commands.ContainsKey(line))
				ThrowError(scope $"Command '{line}' doesnt exist");
			else
				Commands[line](this);
		}
	}

	public bool RegisterCommand(StringView name, function void(Automate) func)
	{
		if(Commands.ContainsKey(name))
			return false;
		Commands.Add(name, func);
		return true;
	}
}
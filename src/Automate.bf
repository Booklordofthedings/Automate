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
		Commands.Add("string->num", => Conversions.StringToNum);
		Commands.Add("num->string", => Conversions.NumToString);
		Commands.Add("string->bool", => Conversions.StringToBool);
		Commands.Add("bool->string", => Conversions.BoolToString);

		//Math
		Commands.Add("+", => Automate.Commands.Math.Add);
		Commands.Add("-", => Automate.Commands.Math.Sub);
		Commands.Add("*", => Automate.Commands.Math.Mult);
		Commands.Add("/", => Automate.Commands.Math.Div);
		Commands.Add("sqrt", => Automate.Commands.Math.Root);
		Commands.Add("%", => Automate.Commands.Math.Modulo);
		Commands.Add("pow", => Automate.Commands.Math.Pow);
		Commands.Add("sqr", => Automate.Commands.Math.Square);
		Commands.Add("cube", => Automate.Commands.Math.Cube);
		Commands.Add("pi", => Automate.Commands.Math.Pi);
		Commands.Add("round", => Automate.Commands.Math.Round);
		Commands.Add("roundfin", => Automate.Commands.Math.RoundFin);

		//IO
		Commands.Add("mkf", => Files.MakeFile);
		Commands.Add("rmf", => Files.DeleteFile);
		Commands.Add("mkd", => Directories.MakeDirectory);
		 
		//Debugging
		Commands.Add("print", => Echo.Echo);
		Commands.Add("printf", => Echo.Print);

		//Functions
		Commands.Add("call", => Functions.Call);
		Commands.Add("return", => Functions.Return);
		Commands.Add("goto", => Functions.Goto);
		Commands.Add("gorel", => Functions.GotoRelative);
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
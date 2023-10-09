namespace Automate.Machine;
using System.Collections;
using System;
/*
	The main class that runs all commands
	Any caller registers all commands they want to be able to use here
	Users can either directly input Strings or have them be "optimized" to use the command ids directly
	This makes the direct call from a string slower, however it allows us to run the optimized code faster
	!!!!Loading too many optimized function on one runner can impact performance
	Unloading is not availble, instead you just throw the runner away and use a different one
	TODO: Better debugging features
*/
class AutomateRunner
{
	private typealias FunctionSignature = function bool(MachineState);
	private typealias ObjectParseSignature = function Result<Variant>(StringView);

	private List<FunctionSignature> _commands; //The actual commands are accessed by index
	private Dictionary<StringView, int64> _lookupFunctions; //Lookup table
	private Dictionary<StringView, ObjectParseSignature> _lookupObjects; //Lookup table for object parsing
	//List of all optimized programs, these need to be stored here, because lookup commands are relative to each execution
	//The second list contains all values and types, these are indicated by using a negative value in the first list
	private Dictionary<StringView, (List<int64>, List<(StringView, StringView)>)> _optimizeds;


	private List<String> _errorStrings; //Allows us to allocate strings without users having to clean up, beyond deleting this runner
	
	public this()
	{
		_commands = new .();
		_lookupFunctions = new .();
		_lookupObjects = new .();
		_optimizeds = new .();
		_errorStrings = new .();
	}

	public ~this()
	{
		delete _commands;
		delete _lookupFunctions;
		delete _lookupObjects;
		for(var e in _optimizeds)
		{
			delete e.value.0;
			delete e.value.1;
		}
		delete _optimizeds;
		DeleteContainerAndItems!(_errorStrings);
	}

	///Register a function by Name
	public bool RegisterFunction(StringView pName, FunctionSignature pFunction)
	{
		_commands.Add(pFunction);
		var res = _lookupFunctions.TryAdd(pName, _commands.Count-1);
		return res;
	}
	
	public bool RegisterType(StringView pType, ObjectParseSignature pFunction)
	{
		var res = _lookupObjects.TryAdd(pType, pFunction);
		return res;
	}

	/// Optimize a list of commands and return wether it suceeded
	/// @param pDoCodeOptimization Wether this should actually change the code itself to optimize, may break certain commands
	public bool Optimize(StringView pName, StringView pLines, bool pDoCodeOptimization = false)
	{
		bool toReturn = true;
		//TODO: If code optimization is on we need to also find patterns and optimize those
		List<int64> lines = new .(); //Commands to be executed for earch line
		List<(StringView, StringView)> objects = new .();
		objects.Add(("null","null")); //-0 does not exists, or atleast is not handled, so we need some way to ensure this doesnt error

		var enumerator = pLines.Split('\n');
		next: for(var line in enumerator)
		{
			if(line == "" || line.StartsWith('#'))
			{
				lines.Add(0);
				continue next;
			}
			var res = _lookupFunctions.GetValue(line);
			if(res case .Ok(let val))
				lines.Add(val);
			//-int> == type, its likely a type now
			if(line.StartsWith('-'))
			{
				if(!line.Contains('>'))
				{
					toReturn = false;
					continue next;
				}

				var endOfType = line.IndexOf(">");
				StringView type = .(line, 1, endOfType-1);
				StringView content = .(line, endOfType+1); //Divide up lines

				objects.Add((type, content));
				lines.Add((objects.Count-1) * -1); //Negative numbers indicate objects instead of commands
			}
		}
		if(toReturn)
			_optimizeds.Add(pName, (lines, objects));
		else
		{
			delete lines;
			delete objects;
		}
		return toReturn;
		
	}

	///Run code directly, it will be optimized internally
	public Result<void, StringView> RunUnoptimized(StringView code)
	{
		MachineState state = new .();
		var enumerator = code.Split('\n');
		int counter = 0;
		for(var line in enumerator)
		{
			counter++;
			if(line.StartsWith('#'))
				continue;
			else if(line.StartsWith('-') || line.Contains('>'))
			{
				StringView type = .(line, 1, line.IndexOf('>')-1);
				StringView value = .(line, line.IndexOf('>')+1);
				if(!_lookupObjects.ContainsKey(type))
				{
					Console.WriteLine(type);
					_errorStrings.Add(new String(scope $"Error parsing type on line: {counter}"));
					delete state;
					return .Err(_errorStrings[^1]);
				}
				var res = _lookupObjects[type](value);
				if(res case .Err)
				{
					_errorStrings.Add(new String(scope $"Error parsing type on line: {counter}"));
					delete state;
					return .Err(_errorStrings[^1]);
				}
				state.Stack.Add(res.Value);
			}
			else
			{
				if(!_lookupFunctions.ContainsKey(line))
				{
					_errorStrings.Add(new String(scope $"Couldnt find function on line: {counter}"));
					delete state;
					return .Err(_errorStrings[^1]);
				}
				var res = _commands[_lookupFunctions[line]](state);
				if(res == false)
				{
					_errorStrings.Add(new String(scope $"Error on line: {counter}"));
					return .Err(_errorStrings[^1]);
				}
			}
		}
		delete state;
		return .Ok;
	}

	///Run a packet of code that you have previously called optimized on
	public Result<void, StringView> Run(StringView pName)
	{
		if(!_optimizeds.ContainsKey(pName))
		{
			_errorStrings.Add(new String(scope $"Unable to run program named: {pName}. Maybe you have not called optimize on a program of that name yet"));
			return .Err(_errorStrings[^1]);
		}
		let commands = _optimizeds[pName];

		MachineState state = new .();
		for(int i < commands.0.Count)
		{
			var c = commands.0[i];
			if(c >= 0)
			{
				var res = _commands[c](state);
				if(res == false)
				{
					_errorStrings.Add(new String(scope $"An error occured on line: {i}"));
					delete state;
					return .Err(_errorStrings[^1]);
				}
			}
			else
			{
				var type = commands.1[c*-1];
				var res = _lookupObjects[type.0](type.1);
				if(res case .Err)
				{
					_errorStrings.Add(new String(scope $"An error occured parsing data on line: {i}"));
					delete state;
					return .Err(_errorStrings[^1]);
				}
				state.Stack.Add(res.Value);
			}
			//TODO: read stuff from state to see if things have changed
		}
		delete state;
		return .Ok;
	}
}
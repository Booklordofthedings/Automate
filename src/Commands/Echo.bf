namespace Automate.Commands;
using Automate.Machine;
using System;
class Echo
{
	public static bool Echo(MachineState state)
	{
		System.Console.WriteLine(state.Stack[^1].Get<String>());
		return true;
	}
}
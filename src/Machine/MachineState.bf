namespace Automate.Machine;
using System.Collections;
using System;
class MachineState
{
	/*
		State that a runner needs to work
		Things like registers and functions can be added here in the future
	*/

	public List<Variant> Stack; //Representing the stack

	public this()
	{
		Stack = new .();
	}

	public ~this()
	{
		for(var e in Stack)
			e.Dispose();
		delete Stack;
	}

}
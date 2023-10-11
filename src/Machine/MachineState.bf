namespace Automate.Machine;
using System.Collections;
using System;
class MachineState
{
	/*
		This machine state is how functions interface with the runner
		Basic interface functionality includes setting an error, or moving the program counter
	*/

	public List<Variant> Stack; //Representing the stack
	public int ProgramCounter {get; set;} = 0; //Allows programs to do goto type stuff

	private String ErrorString = null;
	public bool HasErrored
	{
		public get {
		return ErrorString != null;
		}
		private set{}
	}

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
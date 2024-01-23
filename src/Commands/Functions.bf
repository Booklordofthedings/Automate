namespace Automate.Commands;
using Automate;
using System;
class Functions
{
	public static void Call(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(String))
		{
			au.Instructions.Call(obj.Get<String>());
		}
		else
			au.ThrowError("Cannot call function with a nonstring value");
	}

	public static void Return(Automate au)
	{
		au.Instructions.Return();
	}

	public static void Goto(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
		{
			au.Instructions.SetProgramCounter((.)obj.Get<double>());
			if(au.Instructions.GetProgramCounter() >= au.Instructions.MaxProgramCounter() || au.Instructions.GetProgramCounter() < 0)
				au.ThrowError("Program counter out of bounds");
		}
		else
			au.ThrowError("Cannot go to non number location");
	}

	public static void GotoRelative(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
		{
			au.Instructions.SetProgramCounter(au.Instructions.GetProgramCounter() + (.)obj.Get<double>());
			if(au.Instructions.GetProgramCounter() >= au.Instructions.MaxProgramCounter() || au.Instructions.GetProgramCounter() < 0)
				au.ThrowError("Program counter out of bounds");
		}
		else
			au.ThrowError("Cannot go to non number location");
	}

	public static void JumpIfZero(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
		{
			var one = au.Stack.Pop!();
			if(one.HasValue && one.VariantType == typeof(double))
			{
				if(one.Get<double>() == 0)
					au.Instructions.SetProgramCounter((.)obj.Get<double>());
			}
			else
				au.ThrowError("No valid value to compare to 0");
		}
		else
			au.ThrowError("No valid target jump value");
	}

	public static void Jump(Automate au)
	{
		var obj = au.Stack.Pop!();
		if(obj.HasValue && obj.VariantType == typeof(double))
		{
			var value = au.Stack.Pop!();
			if(value.HasValue && value.VariantType == typeof(bool))
			{
				if(value.Get<bool>())
					au.Instructions.SetProgramCounter((.)obj.Get<double>());
			}
		}
		else
			au.ThrowError("Cannot jump to a non numerical value");
	}
}
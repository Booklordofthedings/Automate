namespace Automate;
using System;
using System.Collections;
class AutomateInstructions
{

	private List<StringView> _Instructions = new .(200) ~ delete _;
	private Dictionary<StringView, int64> _Labels = new .(5) ~ delete _;
	private Dictionary<StringView, double> _Literals = new .(10) ~ delete _; 
	private int _OffsetCounter = 0;
	private int _ProgramCounter = 0;

	///Append a piece of code to the code counter and parse labels
	[Inline]
	public void LoadCode(StringView pToLoad)
	{
		var split = pToLoad.Split('\n',.None);
		for(var line in split)
		{
			_OffsetCounter++;
			if(line.StartsWith('$'))
				_Labels.Add(.(line,1),_OffsetCounter);
			else if(line.StartsWith('<'))
			{
				if(!_Literals.ContainsKey(line))
				{
					var res = double.Parse(.(line,1));
					if(res case .Ok(let val))
					_Literals.Add(line,val);

				}

			}
			_Instructions.Add(line);
		}
	}

	///Removes all loaded code, labels and resets the program counter
	[Inline]
	public void Clear()
	{
		_Instructions.Clear();
		_Labels.Clear();
		_Literals.Clear();
		_OffsetCounter = 0;
		_ProgramCounter = 0;
	}

	///Sets the program counter to the position of a specific label or returns false
	[Inline]
	public bool Goto(StringView pLabel)
	{
		if(!_Labels.ContainsKey(pLabel))
			return false;
		_ProgramCounter = _Labels[pLabel];
		return true;
	}

	[Inline]
	public void SetProgramCounter(int64 pValue)
	{
		_ProgramCounter = pValue;
	}

	[Inline]
	public int64 GetProgramCounter()
	{
		return _ProgramCounter;
	}

	[Inline]
	public int64 MaxProgramCounter()
	{
		return _OffsetCounter;
	}

	[Inline]
	public StringView GetNextCommand()
	{
		if(_ProgramCounter < _OffsetCounter)
		{
			_ProgramCounter++;
			return _Instructions[_ProgramCounter-1];
			
		}
		return "exit";
	}
}
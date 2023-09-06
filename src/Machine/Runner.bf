namespace Automate.Machine;
using System;
using System.Collections;
class Runner
{
	public List<String> LoadedFiles = new List<String>() ~ DeleteContainerAndItems!(_); // We dont really want to use true string objects
	public List<StringView> Lines = new List<StringView>(100) ~ delete _; //Where we execute everything
	public int Index = 0;
	public List<Stackobject> Stack = new List<Stackobject>(100) ~ DeleteContainerAndItems!(_);
	public bool MoveAfterInstruction = false;
	public bool ErrorOccured = false;
	public StringView ErrorValue = "";

	public void StringToList(String pArg, List<StringView> pOut)
	{
		var enumerator = pArg.Split("\n",.RemoveEmptyEntries);
		for(let i in enumerator)
		{
			pOut.Add(i);
		}
	}

	public void Run()
	{
		l: while(Index < Lines.Count)
		{
			if(ErrorOccured)
			{
				Console.WriteLine(scope $"{ErrorValue} has occured on Index: {Index}");
				return;
			}

			//This is used by jump instructions so that the user doesnt have to jump one infront
			if(MoveAfterInstruction)
				Index++;
			MoveAfterInstruction = true;

			StringView line = Lines[Index];
			if(line.StartsWith('#')) //Comments
				continue l;
#region data
			if(line.StartsWith("-t> "))
			{ //Text
				line = .(line,4);
				Stackobject toAdd = new .();
				toAdd.Type = .Text;
				toAdd.Object.Text = new .(line);
			}
			else if(line.StartsWith("-n> "))
			{ //Number
				line = .(line,4);
				Stackobject toAdd = new .();
				toAdd.Type = .Number;
				var res = double.Parse(line);
				if(res == .Err)
				{
					ErrorOccured = true;
					ErrorValue = "Number parsing error";
					delete toAdd;
					continue l;
				}
				toAdd.Object.Number = res.Value;

			}
			else if(line.StartsWith("-i> "))
			{ //Integer
				line = .(line,4);
				Stackobject toAdd = new .();
				toAdd.Type = .Int;
				var res = int64.Parse(line);
				if(res case .Err(let r))
				{
					ErrorOccured = true;
					ErrorValue = "Integer parsing error";
					delete toAdd;
					continue l;
				}
				toAdd.Object.Number = res.Value;
			}
#endregion

			switch(line)
			{ //Commands

			}

		}
	}
}
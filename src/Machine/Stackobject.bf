namespace Automate.Machine;
using System;
using System.IO;

class Stackobject
{
	public StackobjectType Type;
	public sObject Object;

	public ~this()
	{
		if(Type == .Text)
			delete Object.Text;

	}

	public override void ToString(String strBuffer)
	{
		switch(this.Type)
		{
		case .Text:
			strBuffer.Append(Object.Text);
		case .Number:
			strBuffer.Append(Object.Number.ToString(.. scope .()));
		case .Int:
			strBuffer.Append(Object.Int.ToString(.. scope .()));
		case .Dir:
			strBuffer.Append("A directory");
		case .File:
			strBuffer.Append("A file");

		}
	}
}

enum StackobjectType
{
	Text,
	Number,
	Int,
	Dir,
	File
}

[Union]
struct sObject
{
	public String Text;
	public double Number;
	public int64 Int;
	public Directory Dir;
	public File File;
}
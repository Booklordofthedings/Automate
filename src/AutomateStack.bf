namespace Automate;
using System;
using System.Collections;
class AutomateStack
{
	private List<Variant> _Stack = new List<Variant>(100) ~ DeleteContainerAndDisposeItems!(_);

	///Peek the last added object
	[Inline]
	public Variant Peek()
	{
		if(_Stack.Count > 0)
			return _Stack[^1];
		return .();
	}

	///Peek the nth last added object
	[Inline]
	public Variant PeekN(int pOffset)
	{
		if(_Stack.Count > pOffset)
			return _Stack[^pOffset];
		return .();
	}

	///Add a new variant to the stack
	[Inline]
	public void Push(Variant pToAdd)
	{
		_Stack.Add(pToAdd);
	}

	[Inline]
	public void Clear()
	{
		for(var i in _Stack)
			i.Dispose();
		_Stack.Clear();
	}

	///Pops the highest object on the stack
	[Inline]
	public Variant Pop()
	{
		if(_Stack.Count > 0)
			return _Stack.PopBack();
		return .();
	}

	///Pops the highest object and automatically disposes it in the scope of it being called
	public mixin Pop()
	{
		var val = Pop();
		defer:mixin val.Dispose();
		val
	}

	public int Length
	{
		get
		{
			return _Stack.Count;
		}
	}
}
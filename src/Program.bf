namespace Automate;
using System;
class Program
{
	//[Test]
	public static void Main()
	{
		String other = """
			>filename.dsad
			mkd
			""";
		//490k instructions per ms
		//1824ms


		Automate o = scope .();
		o.Instructions.LoadCode(other);
		o.Run();
		o.Stack.Clear();
		Console.Read();
	}
}
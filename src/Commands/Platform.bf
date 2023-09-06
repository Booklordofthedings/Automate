namespace Automate.Commands;
using Automate.Machine;
class Platform
{
	public static void Echo(Runner toRun)
	{
		var obj = toRun.Stack.PopBack();
		System.Console.WriteLine(obj.ToString(.. scope .()));
	}
}
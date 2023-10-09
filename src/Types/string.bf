namespace Automate.Types;
using System;
class string
{
	public static Result<Variant> Parse(StringView pParam)
	{
		Variant v = .Create<String>(new .(pParam),true);
		return .Ok(v);
	}
} 
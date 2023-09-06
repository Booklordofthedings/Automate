namespace System.Collections;

extension List<T>
{
	/*TODO:
		This is slow and I know it
		we can theoretically just grow the internal buffer
		and copy data over.
		Maybe do this in the future, this is supposed to be simple though
	*/
	public void InsertListAt(List<T> pOther, int pIndex)
	{
		for(int i = 0; i < pOther.Count; i++)
		{
			this.Insert(pIndex+i, pOther[i]);
		}
	}
}
package Frame;

public class AccessList {
	// AccessList用于把Access连成链表
	public Access head;
	public AccessList next;
	public AccessList(Access h, AccessList n)
	{
		head = h;	next = n;
	}
}

package Translate;
//存放特定的静态信息
public class Library {
	public static int WORDSIZE = 4;//在mips框架下,1个字4bytes(表示一个mips机器字,为32个二进制位)
	public static java.util.Hashtable<Temp.Label, String> hsLab2Str;
}

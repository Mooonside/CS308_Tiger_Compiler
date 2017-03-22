package Frame;

public abstract class Access {
	//用于描述那些存放在帧中或是寄存器中的形式参数和局部变量
	public abstract Tree.Exp exp(Tree.Exp framePtr);//以 fp 为起始地址返回变量
	public abstract Tree.Exp expFromStack(Tree.Exp stackPtr); //以 sp 为起始地址返回变量
}

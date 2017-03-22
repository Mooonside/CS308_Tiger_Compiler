package Mips;

import Tree.*;
// 表示保存在帧空间中
public class InFrame extends Frame.Access {
	private MipsFrame frame;
	public int offset;//帧中偏移量
	
	public InFrame(MipsFrame frame, int offset) 
	{
		this.frame = frame;
		this.offset = offset;
	}
	
	public Tree.Exp exp(Tree.Exp framePt) 
	{
		//以 fp 为起始地址返回变量的 IR 树结点
		return new MEM(new BINOP(BINOP.PLUS, framePt, new CONST(offset)));
	}
	
	public Tree.Exp expFromStack(Tree.Exp stackPtr) 
	{
		//以 sp 为起始地址返回变量的 IR 树结点
		//fp = sp + 帧空间 + 4bytes
		return new MEM(new BINOP(BINOP.PLUS, stackPtr, new CONST(offset - frame.allocDown - Translate.Library.WORDSIZE)));
	}
	
}
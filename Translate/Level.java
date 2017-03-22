package Translate;

import Symbol.Symbol;
import Util.*;

public class Level {
	public Level parent;
	public Frame.Frame frame;//层中对应的帧
	public AccessList formals = null;//参数表
	//构建一个新层
	public Level(Level parent, Symbol name, BoolList fmls)
	{
		this.parent = parent;
		BoolList bl = new BoolList(true, fmls);
		this.frame = parent.frame.newFrame(new Temp.Label(name), bl);
		for (Frame.AccessList f = frame.formals; f != null; f = f.next)
			this.formals = new AccessList(new Access(this, f.head), this.formals);
	}
	public Level(Frame.Frame frm){
		//重载构造函数，令父层为空
		this.frame = frm;	this.parent = null;
	}
	public Access staticLink() {
		//返回这一层的静态链,对于函数而言就是寄存器$a0
		return formals.head;
	}
	public Access allocLocal(boolean escape){
		//按逃逸信息分配空间
		return new Access(this, frame.allocLocal(escape));	
	}
}

package Translate;

import Temp.*;
import Tree.*;
//条件表达式生成中间代码
public abstract class Cx extends Exp{
	Tree.Exp unEx()
	{
		Temp r = new Temp();//返回值
		Label t = new Label();//true出口
		Label f = new Label();//false出口
		/*将语句翻译成 
		r=1
		if (exp!=0) goto T else goto F (具体处理由子类完成)
		LABEL f: 
			r = 0
		LABEL t: 
			return r 
		的结构。*/
		return new ESEQ(
				new SEQ(new MOVE(new TEMP(r), new CONST(1)),
				new SEQ(unCx(t, f),//由子类完成
				new SEQ(new LABEL(f),
				new SEQ(new MOVE(new TEMP(r), new CONST(0)),
				new LABEL(t))))),new TEMP(r));
	}
	abstract Stm unCx(Label t, Label f); //子类
	public Stm unNx(){	return new Tree.Exp(unEx());} //留给子类具体处理
}

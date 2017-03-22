package Translate;

import Temp.*;
// 有返回值表达式
public class Ex extends Exp{
	Tree.Exp exp;
	public Ex(Tree.Exp e){
		exp = e;
	}

	Tree.Exp unEx(){
		return exp;
	}
	// Tree.Exp 是Tree.Stm的子类
	public Tree.Stm unNx(){
		return new Tree.Exp(exp);
	}
	// if (exp!=0) goto T else goto F
	Tree.Stm unCx(Label t, Label f)
	{	return new Tree.CJUMP(Tree.CJUMP.NE, exp, new Tree.CONST(0), t, f);	}

}

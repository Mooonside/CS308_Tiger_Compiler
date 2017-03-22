package Translate;

import Temp.*;
import Tree.*;

public class ForExp extends Exp{
	Level currentL; //当前层
	Access var; //循环变量
	Exp initial, ternminal, body; //初始,终止,循环体
	Label out; //出口
	
	ForExp(Level home, Access var, Exp initial, Exp ternminal, Exp body, Label out) {
		this.currentL = home;
		this.var = var;
		this.initial = initial;
		this.ternminal = ternminal;
		this.body = body;
		this.out = out;
	}
	//for语句没有返回值,不能转换为Ex
	Tree.Exp unEx(){
		return null;
	}

	public Tree.Stm unNx(){
		Access taccess = currentL.allocLocal(true);
		Label begin = new Label();
		Label goon = new Label();
		return new SEQ(new MOVE(var.acc.exp(new TEMP(currentL.frame.FP())),initial.unEx()), 
		               new SEQ(new MOVE(taccess.acc.exp(new TEMP(currentL.frame.FP())),ternminal.unEx()), 
		               new SEQ(new CJUMP(CJUMP.LE, var.acc.exp(new TEMP(currentL.frame.FP())), taccess.acc.exp(new TEMP(currentL.frame.FP())), begin, out),
		               new SEQ(new LABEL(begin), 
		              new SEQ(body.unNx(), 
				       new SEQ(new CJUMP(CJUMP.LT, var.acc.exp(new TEMP(currentL.frame.FP())),	taccess.acc.exp(new TEMP(currentL.frame.FP())), goon, out), 
					   new SEQ(new LABEL(goon),
					   new SEQ(new MOVE( var.acc.exp(new TEMP(currentL.frame.FP())), new BINOP(BINOP.PLUS, var.acc.exp(new TEMP(currentL.frame.FP())), new CONST(1))),
					   new SEQ(new JUMP(begin), new LABEL(out))))))))));
	}
	//for循环只有一个出口,不能转换
	Tree.Stm unCx(Label t, Label f){
		return null;
	}
}

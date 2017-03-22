package Translate;
import Temp.*;

public class Nx extends Exp{
	Tree.Stm stm;
	
	Nx(Tree.Stm s){	
		stm =  s;	
	}
	
	Tree.Exp unEx(){
		 //无返回值
		return null;
	}
	
	public Tree.Stm unNx(){	
		return stm;	}
	
	Tree.Stm unCx(Label t, Label f){
		return null;
	}
}

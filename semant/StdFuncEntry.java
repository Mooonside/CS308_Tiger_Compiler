package semant;

import Types.*;
//标准库函数entry
public class StdFuncEntry extends FuncEntry {
	public StdFuncEntry(Translate.Level l, Temp.Label lab, RECORD params, Type rt)
	{
		//继承变量
		super(l, lab, params, rt);
	}
}

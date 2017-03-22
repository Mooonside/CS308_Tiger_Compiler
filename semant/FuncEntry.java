package semant;

import Types.*;
//用户函数entry
public class FuncEntry extends Entry{
	RECORD paramlist;//参数表
	Type returnTy;//返回值类型
	public Translate.Level level;//层
	public Temp.Label label;//函数的label
	
	public FuncEntry(Translate.Level level, Temp.Label label, RECORD p, Type rt)
	{
		this.level = level;
		this.label = label;
		paramlist = p;
		returnTy = rt;
	}
}

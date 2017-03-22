package semant;

import Types.*;
import Symbol.*;
import tiger.errormsg.*;
import Translate.Level;
import Util.BoolList;

public class Env {
	Table vEnv = null; 
	Table tEnv = null; 
	Level root = null; 	//传入main函数,添加库函数时使用
	ErrorMsg errorMsg = null;	
	//记录库函数名的哈希表，在判别是否有用户定义重名函数时使用
	java.util.HashSet<Symbol> stdFuncSet = new java.util.HashSet<Symbol>();

	Env(ErrorMsg err, Level l)
	{
		errorMsg = err;
		root = l;
		initTEnv();
		initVEnv();
	}
	
	public void initTEnv() 
	{
		//j加入两个保留类
		tEnv = new Table();
		tEnv.put(Symbol.symbol("int"), new INT());
		tEnv.put(Symbol.symbol("string"), new STRING());
	}
	public void initVEnv() 
	{
		//加入库函数的信息
		vEnv = new Table();
		
		Symbol sym = null; //函数名
		RECORD formals = null; //变量表
		Type result = null; //返回类型
		Level level = null; //层

		sym = Symbol.symbol("allocRecord");
		formals = new RECORD(Symbol.symbol("size"), new INT(), null);
		result = new INT();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("initArray");
		formals = new RECORD(Symbol.symbol("size"), new INT(), new RECORD(Symbol.symbol("init"), new INT(), null));
		result = new INT();
		level = new Level(root, sym, new BoolList(true, new BoolList(true, null)));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("print");
		formals = new RECORD(Symbol.symbol("str"), new STRING(), null);
		result = new VOID();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("flush");
		formals = null;
		result = new VOID();
		level = new Level(root, sym, null);
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("getchar");
		formals = null;
		result = new STRING();
		level = new Level(root, sym, null);
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("ord");
		formals = new RECORD(Symbol.symbol("str"), new STRING(), null);
		result = new INT();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("chr");
		formals = new RECORD(Symbol.symbol("i"), new INT(), null);
		result = new STRING();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("size");
		formals = new RECORD(Symbol.symbol("str"), new STRING(), null);
		result = new INT();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("substring");
		//注意存入多个参数的顺序
		formals = new RECORD(Symbol.symbol("n"), new INT(), null);
		formals = new RECORD(Symbol.symbol("first"), new INT(), formals);
		formals = new RECORD(Symbol.symbol("str"), new STRING(), formals);
		result = new STRING();
		level = new Level(root, sym, new BoolList(true, new BoolList(true, new BoolList(true, null))));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("concat");
		formals = new RECORD(Symbol.symbol("str2"), new STRING(), null);
		formals = new RECORD(Symbol.symbol("str1"), new STRING(), formals);
		result = new STRING();
		level = new Level(root, sym, new BoolList(true, new BoolList(true, null)));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("not");
		formals = new RECORD(Symbol.symbol("j"), new INT(), null);
		result = new INT();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("exit");
		formals = new RECORD(Symbol.symbol("k"), new INT(), null);
		result = new VOID();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);
		
		sym = Symbol.symbol("printi");
		formals = new RECORD(Symbol.symbol("i"), new INT(), null);
		result = new VOID();
		level = new Level(root, sym, new BoolList(true, null));
		vEnv.put(sym, new StdFuncEntry(level, new Temp.Label(sym), formals, result));
		stdFuncSet.add(sym);		
	}
}

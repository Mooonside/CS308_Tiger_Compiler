package semant;

import java.io.FileNotFoundException;
import Absyn.FieldList;
import tiger.errormsg.*; 
import Translate.Level;
import Types.*;
import Util.BoolList;
import Symbol.Symbol;
/*
当检查某个语法结点时, 需递归地检查结点的每个子语法成分, 确认所有子语法成分的正确且翻译完毕后, 调用Translate对整个表达式进行翻译.
对表达式的检查称为语义分析, 和中间代码的翻译是联系在一起的.
 */
public class Semant {
    private Env env;//符号表
	private Translate.Translate trans;
	private Translate.Level level = null;
    //用于循环嵌套的栈堆,需要设置为Semant全局,供函数调用
	private java.util.Stack<Temp.Label> loopStack = new java.util.Stack<Temp.Label>();
	
	public Semant(Translate.Translate t, ErrorMsg err){
		trans = t;
		level = new Level(t.frame);
		level = new Level(level, Symbol.symbol("main"), null);
		env = new Env(err, level);
	}
	
	public Frag.Frag transProg(Absyn.Exp e) throws FileNotFoundException{ 
		//语义检查,并翻译成IR树
		ExpTy et = transExp(e);
        //若有语义错误,报错输出
		if(ErrorMsg.anyErrors){
			System.out.println("Find semant error, end compiling!");
			return null;
		}
		//输出翻译结果
		java.io.PrintStream ir;
		ir = new java.io.PrintStream(new java.io.FileOutputStream("irTree.txt"));
	    Tree.Print print = new Tree.Print(ir);
	    print.prStm(et.exp.unNx());
		//添加函数调用部分的代码
		trans.procEntryExit (level, et.exp, false); 
        //回到上一层
		level = level.parent;
        //返回翻译结束后的段列表
		return trans.getResult(); 
	}

	public ExpTy transVar(Absyn.Var e){
		if (e instanceof Absyn.SimpleVar) return transVar((Absyn.SimpleVar)e);
		if (e instanceof Absyn.SubscriptVar) return transVar((Absyn.SubscriptVar)e);
		if (e instanceof Absyn.FieldVar) return transVar((Absyn.FieldVar)e);
		return null;
	}
	public ExpTy transExp(Absyn.Exp e){
		if (e instanceof Absyn.IntExp) return transExp((Absyn.IntExp)e);
		if (e instanceof Absyn.StringExp) return transExp((Absyn.StringExp)e);
		if (e instanceof Absyn.NilExp) return transExp((Absyn.NilExp)e);
		if (e instanceof Absyn.VarExp) return transExp((Absyn.VarExp)e);
		if (e instanceof Absyn.OpExp) return transExp((Absyn.OpExp)e);
		if (e instanceof Absyn.AssignExp) return transExp((Absyn.AssignExp)e);
		if (e instanceof Absyn.CallExp) return transExp((Absyn.CallExp)e);
		if (e instanceof Absyn.RecordExp) return transExp((Absyn.RecordExp)e);
		if (e instanceof Absyn.ArrayExp) return transExp((Absyn.ArrayExp)e);
		if (e instanceof Absyn.IfExp) return transExp((Absyn.IfExp)e);
		if (e instanceof Absyn.WhileExp) return transExp((Absyn.WhileExp)e);
		if (e instanceof Absyn.ForExp) return transExp((Absyn.ForExp)e);
		if (e instanceof Absyn.BreakExp) return transExp((Absyn.BreakExp)e);
		if (e instanceof Absyn.LetExp) return transExp((Absyn.LetExp)e);
		if (e instanceof Absyn.SeqExp) return transExp((Absyn.SeqExp)e);
		return null;
	}
	
	private ExpTy transDecList(Absyn.DecList e){
		Translate.Exp ex = null;
		// 先将所有head放入符号表
		for (Absyn.DecList i = e; i!= null; i = i.tail){
			Absyn.Dec declaration = i.head;
			transDecHead(declaration);
		}
		// 将所有的body翻译连起来
		for (Absyn.DecList i = e; i!= null; i = i.tail){
			ex = trans.stmcat(ex, transDecBody(i.head));
		}
		return new ExpTy(ex, new VOID());
	}
	public void transDecHead(Absyn.Dec e){
		//翻译声明的head(填入vEnv|tEnv).
		if (e instanceof Absyn.VarDec) transDecHead((Absyn.VarDec)e);
		if (e instanceof Absyn.TypeDec) transDecHead((Absyn.TypeDec)e);
		if (e instanceof Absyn.FunctionDec) transDecHead((Absyn.FunctionDec)e);
	}
	public Translate.Exp transDecBody(Absyn.Dec e){
		if (e instanceof Absyn.VarDec)  return transDecBody((Absyn.VarDec)e);
		if (e instanceof Absyn.TypeDec) 	return transDecBody((Absyn.TypeDec)e);
		if (e instanceof Absyn.FunctionDec) return transDecBody((Absyn.FunctionDec)e);
		return null;
	}
	public Type transTy(Absyn.Ty e){
		if (e instanceof Absyn.ArrayTy) return transTy((Absyn.ArrayTy)e);
		if (e instanceof Absyn.RecordTy) return transTy((Absyn.RecordTy)e);
		if (e instanceof Absyn.NameTy) return transTy((Absyn.NameTy)e);
		return null;
	}	
	private ExpTy transExp(Absyn.IntExp e){
		return new ExpTy(trans.transIntExp(e.value), new INT());
	}
	private ExpTy transExp(Absyn.StringExp e){
		return new ExpTy(trans.transStringExp(e.value), new STRING());
	}
	private ExpTy transExp(Absyn.NilExp e){
		return new ExpTy(trans.transNilExp(), new NIL());
	}
	private ExpTy transExp(Absyn.VarExp e){
		return transVar(e.var);
	}
	private ExpTy transExp(Absyn.OpExp e){ 
		//翻译左操作数
		ExpTy el = transExp(e.left);
		//翻译右操作数
		ExpTy er = transExp(e.right); 
		if (el == null || er == null){
			return null;
		}
        //语义检查,检查相等或者不等运算
		if (e.oper == Absyn.OpExp.EQ || e.oper == Absyn.OpExp.NE) {
			if (el.ty.actual() instanceof NIL && er.ty.actual() instanceof NIL){
				env.errorMsg.error(e.pos, "nil cannot compare with nil");
				return null;
			}
			if (el.ty.actual() instanceof VOID || er.ty.actual() instanceof VOID){
				env.errorMsg.error(e.pos, "no void comparison");
				return null;
			}
            //nil op record
			if (el.ty.actual() instanceof NIL && er.ty.actual() instanceof RECORD)
				return new ExpTy(trans.transOpExp(e.oper,el.exp, er.exp), new INT());
			if (el.ty.actual() instanceof RECORD && er.ty.actual() instanceof NIL)
				return new ExpTy(trans.transOpExp(e.oper, transExp(e.left).exp, transExp(e.right).exp), new INT());
            //字符串类要调用Translate中的transStringRelExp
			if (el.ty.coerceTo(er.ty)){
				if (el.ty.actual() instanceof STRING && e.oper == Absyn.OpExp.EQ){
					return new ExpTy(trans.transStringRelExp(level, e.oper, el.exp, er.exp), new INT());
				}
				return new ExpTy(trans.transOpExp(e.oper,el.exp, er.exp), new INT());
			}
			env.errorMsg.error(e.pos, "var types from operation's two sides is not fit");
			return null;
		}
        //若运算符为< <= > >= , 则翻译为普通二目运算语句,注意区分整数和字符串的情况
		if (e.oper > Absyn.OpExp.NE){
			if (el.ty.actual() instanceof INT && er.ty.actual() instanceof INT)
				return new ExpTy(trans.transOpExp(e.oper, transExp(e.left).exp, 
						transExp(e.right).exp), new INT());
			if (el.ty.actual() instanceof STRING && er.ty.actual() instanceof STRING)
				return new ExpTy(trans.transOpExp(e.oper, transExp(e.left).exp,
						transExp(e.right).exp), new STRING());
			env.errorMsg.error(e.pos, "var types from operation's two sides is not fit");
			return null;
		}
		// + - * / 运算
		if (e.oper < Absyn.OpExp.EQ){	
			// 若两边类型一致为int则翻译为普通二目运算语句
			if (el.ty.actual() instanceof INT && er.ty.actual() instanceof INT){
				return new ExpTy(trans.transOpExp(e.oper, transExp(e.left).exp
						, transExp(e.right).exp), new INT());
			}
			env.errorMsg.error(e.pos, "var types from operation's two sides is not fit");
			return null;
		}
		return new ExpTy(trans.transOpExp(e.oper, el.exp, er.exp), new INT());
	}
	private ExpTy transExp(Absyn.AssignExp e){
		int pos=e.pos;
		Absyn.Var var=e.var;// 左值
		Absyn.Exp exp=e.exp;// 右值
		//翻译右值
		ExpTy er = transExp(exp);
		// 若右值为void
		if (er.ty.actual() instanceof VOID)
		{
			env.errorMsg.error(pos, "cannot use void to assign");
			return null;
		}
		// 若左值为简单变量
		if (var instanceof Absyn.SimpleVar){
			Absyn.SimpleVar ev = (Absyn.SimpleVar)var;
			Entry x= (Entry)(env.vEnv.get(ev.name));
			// 判断是不是循环变量
			if (x instanceof VarEntry && ((VarEntry)x).isLoop){
				env.errorMsg.error(pos, "cannot assign to loop var");
				return null;
			}
		}
		//翻译左值
		ExpTy vr = transVar(var);
		if (!er.ty.coerceTo(vr.ty)){
			// 两边类型不一致报错
				env.errorMsg.error(pos, er.ty.actual().getClass().getSimpleName()+
						" cannot match "+vr.ty.actual().getClass().getSimpleName()+" in assignment ");
				return null;	
		}
		// 赋值表达式无返回值
		return new ExpTy(trans.transAssignExp(vr.exp, er.exp), new VOID());
	}
	private ExpTy transExp(Absyn.CallExp e){
		FuncEntry tempEntry;
		Object funentry = env.vEnv.get(e.func);
		// 找不到符号表中的函数报错
		if ( funentry == null || !( funentry instanceof FuncEntry)){
			env.errorMsg.error(e.pos, " function "+e.func.toString()+" is not difined");
			return null;
		}
		Absyn.ExpList argIn =e.args;// 实参
		tempEntry = (FuncEntry) funentry;// 函数表项
		RECORD argDef = tempEntry.paramlist;// 形参
		// 检查实参和形参是否一致
		while (argIn != null){
			if (argDef == null){
				env.errorMsg.error(e.pos, " function's actual parameters abundance");
				return null;
			}
			ExpTy tmp = transExp(argIn.head);
			if(tmp==null)
			{
				env.errorMsg.error(e.pos, " function's actual parameters hasn't been defined yet");
				return null;
			}
			if (!tmp.ty.coerceTo(argDef.fieldType)){
				env.errorMsg.error(e.pos, " function's actual parameters don't match formal parameters in type");
				return null;
			}
			argIn = argIn.tail;
			argDef = argDef.tail;
		}
		if (argIn == null && !(RECORD.isNull(argDef))){
			// 参数表不一致,缺少参数输入
			env.errorMsg.error(e.pos, " function's actual parameters loss");
			return null;
		}
		
	
		java.util.ArrayList<Translate.Exp> arrl = new java.util.ArrayList<Translate.Exp>();
		for (Absyn.ExpList i = e.args; i != null; i = i.tail){
			// 翻译每个实参对应的表达式
			arrl.add(transExp(i.head).exp);
		}
		// 若为标准库函数,调用transStdCallExp函数
		if ( funentry instanceof StdFuncEntry)
		{
			StdFuncEntry sf = (StdFuncEntry) funentry;
			return new ExpTy(trans.transStdCallExp(level, sf.label, arrl), sf.returnTy);
		}
		// 否则作为普通函数处理,其中标准库函数不必处理静态链,故不必传入函数的层,而标准传入fe.level
		return new ExpTy(trans.transCallExp(level, tempEntry.level, tempEntry.label, arrl), tempEntry.returnTy);
	}
	private ExpTy transExp(Absyn.RecordExp e){
		// 查找符号表
		Type t =(Type)env.tEnv.get(e.typ);
		if (t == null || !(t.actual() instanceof RECORD)){
			env.errorMsg.error(e.pos, " record does not exist");
			return null;
		}
		Absyn.FieldExpList recordIn = e.fields;
		RECORD recordDef = (RECORD)(t.actual());
        // 判断e.fields是不是nil
		if (recordIn == null && recordDef != null)
		{
			env.errorMsg.error(e.pos, " no element in record");
			return null;
		}
		while (recordIn != null){
			//逐个检查传入类型与定义是否匹配
			ExpTy ie = transExp(recordIn.init);
			if (recordDef == null || ie == null ||!ie.ty.coerceTo(recordDef .fieldType) 
				|| recordIn.name != recordDef .fieldName){
				env.errorMsg.error(e.pos, " element in record has different type");
				return null;
			}
			recordIn = recordIn.tail;
			recordDef  = recordDef .tail;
		}	
		// 将record中每个成员变量所对应的表达式装入一个链表中并作为参数传入
		java.util.ArrayList<Translate.Exp> arrl = new java.util.ArrayList<Translate.Exp>();
		for (Absyn.FieldExpList i = e.fields; i != null; i = i.tail)
			arrl.add(transExp(i.init).exp);
		return new ExpTy(trans.transRecordExp(level, arrl), t.actual()); 
	}
	private ExpTy transExp(Absyn.ArrayExp e)
	{
        // 在符号表中查找数组类型
		Type ty = (Type)env.tEnv.get(e.typ);
		if (ty == null || !(ty.actual() instanceof ARRAY)){
			env.errorMsg.error(e.pos, " this type of array does not exist");
			return null;
		}
		// 翻译数组的下标
		ExpTy size = transExp(e.size);
		if (!(size.ty.actual() instanceof INT)){
			env.errorMsg.error(e.pos, " the length of the array is not INT");
			return null;
		}	
		ARRAY ar = (ARRAY)ty.actual();
		// 翻译数组初始值的表达式
		ExpTy ini = transExp(e.init);
		// 如果初始值类型和数组类型不匹配,报错
		if (!ini.ty.coerceTo(ar.element.actual())){
			env.errorMsg.error(e.pos, " init value doesn't match the type declarations");
			return null;
		}
		return new ExpTy(trans.transArrayExp(level, ini.exp, size.exp), new ARRAY(ar.element));			
	}
	private ExpTy transExp(Absyn.IfExp e){
		ExpTy testET = transExp(e.test);// 控制条件
		ExpTy thenET = transExp(e.thenclause);// then
		ExpTy elseET = transExp(e.elseclause);// else
		// 控制条件不能为空,而且必须是int
		if (e.test == null || testET == null || !(testET.ty.actual() instanceof INT)){
			env.errorMsg.error(e.pos, " error of test expression");
			return null;
		}
		// 若没有false分支,则if语句不应有返回值
        if (e.elseclause == null && (!(thenET.ty.actual() instanceof VOID))){
			env.errorMsg.error(e.pos, " there should be no return from then clause");
			return null;
		}		
		// 若存在true/false分支,则二者表达式类型相同
		if (e.elseclause != null && !thenET.ty.coerceTo(elseET.ty)){
			env.errorMsg.error(e.pos, " then and else clause doesn't match");
			return null;
		}
		// 若无false分支,调用 trans.transNoExp()把else分支当作nil处理
		if (elseET == null)
			return new ExpTy(trans.transIfExp(testET.exp, thenET.exp, trans.transNoExp()), thenET.ty);
		return new ExpTy(trans.transIfExp(testET.exp, thenET.exp, elseET.exp), thenET.ty);
	}
	private ExpTy transExp(Absyn.WhileExp e)
	{
		ExpTy transt = transExp(e.test);// 测试语句
		if (transt == null)	return null;
		if (!(transt.ty.actual() instanceof INT)){
			env.errorMsg.error(e.pos, "  error of test expression");
			return null;
		}
		Temp.Label out = new Temp.Label();//循环出口标号
		loopStack.push(out);//将循环压栈一遍处理循环嵌套
		ExpTy bdy = transExp(e.body);//翻译循环体,此处存在递归
		loopStack.pop();//弹出当前循环
        // while循环无返回值
		if (bdy == null)	return null;
		if (!(bdy.ty.actual() instanceof VOID)){
			env.errorMsg.error(e.pos, " while expression should be no return");
			return null;
		}
		return new ExpTy(trans.transWhileExp(transt.exp, bdy.exp, out), new VOID());
	}
	private ExpTy transExp(Absyn.ForExp e){
		boolean flag = false;// 标记循环体是否为空的变量,之后节省为空时的操作时间
		// 循环变量必须是int
		if (!(transExp(e.hi).ty.actual() instanceof INT) 
				|| !(transExp(e.var.init).ty.actual() instanceof INT)){
			env.errorMsg.error(e.pos, " loop var need to be INT");
		}
		// 给循环变量分配新的存储空间,需重开作用域
		env.vEnv.beginScope();
		Temp.Label label = new Temp.Label();//循环入口
        // 循环入栈
        loopStack.push(label);
        //为循环变量分配空间
		Translate.Access acc = level.allocLocal(true);
		// 循环变量加入符号表
		env.vEnv.put(e.var.name, new VarEntry(new INT(), acc, true));
		// 翻译循环体
		ExpTy body = transExp(e.body);
		// 翻译循环变量的终值表达式
		ExpTy high = transExp(e.hi);
		// 翻译循环变量的初始值表达式
		ExpTy low = transExp(e.var.init);
		if (body == null)	flag = true;
        // 弹出循环体
		loopStack.pop();
        // 结束当前定义域
		env.vEnv.endScope();
		if (flag)	return null;
        // for循环无返回值
		return new ExpTy(trans.transForExp(level, acc, low.exp, high.exp, body.exp, label), new VOID());
	}
	private ExpTy transExp(Absyn.BreakExp e){
		// 若break不在循环内使用就报错
		if (loopStack.isEmpty())
		{
			env.errorMsg.error(e.pos, " break is not in loop");
			return null;
		}
		return new ExpTy(trans.transBreakExp(loopStack.peek()), new VOID());// 传入当前的循环,可能为空,s.t.Main
	}
	private ExpTy transExp(Absyn.LetExp e){
		Translate.Exp ex = null;
		env.vEnv.beginScope();
		env.tEnv.beginScope();
        // 翻译let之后的decs
		ExpTy td = transDecList(e.decs);
		if (td != null)
			ex = td.exp;
        // 翻译 in end 之间的语句
		ExpTy tb = transExp(e.body);
		if (tb == null)
			ex = trans.stmcat(ex, null);
		else if (tb.ty.actual() instanceof VOID)
			ex = trans.stmcat(ex, tb.exp);
		else // 连接两部分
			ex = trans.exprcat(ex, tb.exp);
		env.tEnv.endScope();
		env.vEnv.endScope();
		return new ExpTy(ex, tb.ty);
	}
	private ExpTy transExp(Absyn.SeqExp e){
		// 翻译表达式序列,返回序列尾
		Translate.Exp ex = null;
		for (Absyn.ExpList t = e.list; t != null; t = t.tail){
			ExpTy x = transExp(t.head);
            // 序列尾操作
			if (t.tail == null){	
				if(x!=null){
					if (x.ty.actual() instanceof VOID){
						ex = trans.stmcat(ex, x.exp);
					}
					else {
						ex = trans.exprcat(ex, x.exp);
					}
				}
			    if(x!=null) return new ExpTy(ex, x.ty);
			    else return new ExpTy(ex, new VOID());
			}
			else{
				if(x!=null){
					ex = trans.stmcat(ex, x.exp);	
				}
				else {
					ex = trans.stmcat(ex, null);	
				}
			}
		}
		return null;
	}
	private ExpTy transVar(Absyn.SimpleVar e){
		// 翻译简单变量
		Entry ex = (Entry)env.vEnv.get(e.name);
		if (ex == null || !(ex instanceof VarEntry)){
			env.errorMsg.error(e.pos, " loval variable not defined!");
			return null;
		}
		VarEntry evx = (VarEntry)ex;
		return new ExpTy(trans.transSimpleVar(evx.acc, level), evx.Ty);
	}
	private ExpTy transVar(Absyn.SubscriptVar e)
	{
		// 数组下标必须为int
		if (!(transExp(e.index).ty.actual() instanceof INT)){
			env.errorMsg.error(e.pos, " array index must be INT");
			return null;
		}
        // 翻译数组入口
		ExpTy ev = transVar(e.var);
        // 翻译数组下标的表达式
		ExpTy ei = transExp(e.index);
        // 数组入口为空,报错
		if (ev == null || !(ev.ty.actual() instanceof ARRAY)){
			env.errorMsg.error(e.pos, " no such an array");
			return null;
		}
		ARRAY ae = (ARRAY)(ev.ty.actual());
		return new ExpTy(trans.transSubscriptVar(ev.exp, ei.exp), ae.element);
	}
	private ExpTy transVar(Absyn.FieldVar e)
	{
		ExpTy et = transVar(e.var);
		if (!(et.ty.actual() instanceof RECORD)){
			env.errorMsg.error(e.pos, " this variable is not a record variable");
			return null;
		}
		// 逐个查找field
		RECORD rc = (RECORD)(et.ty.actual());
		int count = 1;
		while (rc != null){
			if (rc.fieldName == e.field){
				return new ExpTy(trans.transFieldVar(et.exp, count), rc.fieldType);
			}
			count++;
			rc = rc.tail;
		}
		env.errorMsg.error(e.pos," no such a record");
		return null;
	}
	private Type transTy(Absyn.NameTy e)
	{
        if (e == null)
			return new VOID();
        // 检查入口符号表
		Type t =(Type)env.tEnv.get(e.name);
		if (t == null){
			env.errorMsg.error(e.pos, " no such type record");
			return null;
		}
		return t;
	}
	private ARRAY transTy(Absyn.ArrayTy e){
		Type t = (Type)env.tEnv.get(e.typ);
		if (t == null){
			env.errorMsg.error(e.pos, " no such array type in record");
			return null;
		}
		return new ARRAY(t);
	}
	private RECORD transTy(Absyn.RecordTy e){
		RECORD rc = new RECORD(),  r = new RECORD();
		if (e == null || e.fields == null)
		{
			rc.gen(null, null, null);
			return rc;
		}
		// 检查每个field的类型在 tEnv中是否存在
        Absyn.FieldList fl = e.fields;
		boolean first = true; // 判断是不是第一个field节点
		while (fl != null){
			if (env.tEnv.get(fl.typ) == null){
				env.errorMsg.error(e.pos, " no such a field type");
				return null;
			}
			rc.gen(fl.name, (Type)env.tEnv.get(fl.typ), new RECORD());
			if (first){
				r = rc;// 记录第一个链表节点,供return使用
				first = false;
			}
			if (fl.tail == null)
				rc.tail = null;
			rc = rc.tail;
			fl = fl.tail;
		}
		return r;
	}
	private void transDecHead(Absyn.VarDec e)
	{
		// do nothing
	}
	private Translate.Exp transDecBody(Absyn.VarDec e){
		// 翻译变量定义
		ExpTy et = transExp(e.init);
		// 初始值不能为nil
		if (e.typ == null && e.init instanceof Absyn.NilExp){
			env.errorMsg.error(e.pos, " variable's init cannot be NIL");
			return null;
		}
		// 除记录类型外,其他变量定义必需赋初始值
		if (et == null && e.init==null){
			env.errorMsg.error(e.pos," variable hasn't be initiated");
			 return null;
		}
		if(et == null) {
			// 这里特别处理初始值赋值为()的情况
			et=new ExpTy(trans.transNilExp(), new NIL());
			e.init=new Absyn.NilExp(e.pos);
		}
		// 若初始值与变量类型不匹配则报错
		if (e.typ != null && !(transExp(e.init).ty.coerceTo((Type)env.tEnv.get(e.typ.name)))){
			env.errorMsg.error(e.pos," init value doesn't match the type");
			return null;
		}
		if (e.init == null ){
			env.errorMsg.error(e.pos, " variable hasn't be initiated");
			return null;
		}
		// 为变量分配空间
		Translate.Access acc = level.allocLocal(true);
		if (e.typ != null){//如果定义时指名类型则按照指定类型返回
			env.vEnv.put(e.name, new VarEntry((Type)env.tEnv.get(e.typ.name), acc));
		}
		else{//否则返回其表达式对应的类型值
			env.vEnv.put(e.name, new VarEntry(transExp(e.init).ty, acc));
		}
		return trans.transAssignExp(trans.transSimpleVar(acc, level), et.exp);
	}
	
	private void transDecHead(Absyn.TypeDec e){
		java.util.HashSet<Symbol> hs = new java.util.HashSet<Symbol>();
		// 采用哈希表检查是否有重复定义
        for (Absyn.TypeDec i = e; i != null; i = i.next){
			if (hs.contains(i.name)){ 
				env.errorMsg.error(e.pos, " redeclaration of type in the same field");
				return ;
			}
			hs.add(i.name);
			env.tEnv.put(i.name, new NAME(i.name));
		}
	}
	private Translate.Exp transDecBody(Absyn.TypeDec e){
		// 翻译类型申明语句
		for (Absyn.TypeDec i = e; i != null; i = i.next){			
			NAME tmp = ((NAME)env.tEnv.get(i.name));
			Type tmp_ty = transTy(i.ty);
			tmp.bind(tmp_ty.actual());
			NAME field = (NAME)env.tEnv.get(i.name);
			if(field.isLoop()){
				env.errorMsg.error(i.pos, " type loop definition");
				return null;
			}

		}	
	    //将类型放入类型符号表
	    for (Absyn.TypeDec i = e; i != null; i = i.next)
		    env.tEnv.put(i.name, transTy(i.ty));
		return trans.transNoExp();
	}
	private void transDecHead(Absyn.FunctionDec e)
	{
		for (Absyn.FunctionDec i = e; i != null; i = i.next)
		{
			Absyn.RecordTy rt = new Absyn.RecordTy(i.pos, i.params);
			RECORD  r = transTy(rt);
			if ( r == null)	return;
			// 后检查参数列表,与记录类型RecordTy的检查完全相同,得到 RECORD 类型的形参列表
            BoolList bl = null;
			for (FieldList f = i.params; f != null; f = f.tail)
			{
				bl = new BoolList(true, bl);
			}
			level = new Level(level, i.name, bl);
			env.vEnv.put(i.name, new FuncEntry(level, new Temp.Label(i.name), r, transTy(i.result)));
			level = level.parent;
		}
	}
	
	private Translate.Exp transDecBody(Absyn.FunctionDec e)
	{
		// 翻译函数申明
		java.util.HashSet<Symbol> hs = new java.util.HashSet<Symbol>();
		ExpTy et = null;
		// 检查重复申明,分为普通函数与标准库函数
		for (Absyn.FunctionDec i = e; i != null; i = i.next){
			if (hs.contains(i.name)){
				env.errorMsg.error(e.pos, " function redeclaration");
				return null;
			}
			if (env.stdFuncSet.contains(i.name)){
				env.errorMsg.error(e.pos, " same name with stdfunction");
				return null;
			}
			Absyn.RecordTy rt = new Absyn.RecordTy(i.pos, i.params);
			//翻译函数的参数列表
			RECORD  r = transTy(rt);
			if ( r == null)	return null;
			BoolList bl = null;
			//将参数的逃逸信息全都设为真
			for (FieldList f = i.params; f != null; f = f.tail){
				bl = new BoolList(true, bl);
			}
			//按照参数逃逸信息生成子层
			level = new Level(level, i.name, bl);
			env.vEnv.beginScope();
			//head是上一层的frame指针
			Translate.AccessList al = level.formals.next;
			//将参数的类型填入vEnv中
			for (RECORD j = r; j!= null; j = j.tail){
				if (j.fieldName != null){
					env.vEnv.put(j.fieldName, new VarEntry(j.fieldType, al.head));
					al = al.next;
				}
			}			
			// 翻译函数体
			et = transExp(i.body);
			if (et == null){
                env.vEnv.endScope();
                return null;
            }
			if(!(et.ty.coerceTo((transTy(i.result).actual())))){
				env.errorMsg.error(i.pos," return type doesn't match");
				return null;
			}
			
			if (!(et.ty.actual() instanceof VOID)){ 
				// 检查函数返回值,如无返回值则设置成void
				trans.procEntryExit(level, et.exp, true);
			}
			else{ 
				//若不为void则要将返回值存入$v0寄存器
				trans.procEntryExit(level, et.exp, false);
			}
			env.vEnv.endScope();
            // 函数结束返回上一层
			level = level.parent;
			hs.add(i.name);//for循环调用,存入哈希表
		}
		return trans.transNoExp();
	}
}


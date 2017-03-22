package semant;

import Types.*;
//变量entry
public class VarEntry extends Entry{
	Type Ty;//变量类型
	Translate.Access acc;//为变量分配的存储空间
	boolean isLoop;//标记是否是循环变量（for中的i）
	//重载构造函数
	public VarEntry(Type ty, Translate.Access acc){ 
		Ty = ty; this.acc = acc; this.isLoop=false; }
	public VarEntry(Type ty, Translate.Access acc, boolean isf){ 
		Ty = ty; this.acc = acc; this.isLoop=isf; }
}



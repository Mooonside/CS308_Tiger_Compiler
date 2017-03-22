package Types;
/*
   Type包中封装了类型信息,类名用大写表示以示区分，注意和 Absyn 包中的类型信息区别，后者是根据程序字面翻译而来的,没有经过语义检查
   Type包中类的coerceTo函数描述了关于类型的强制转换部分的信息:
   除了nil类型可以赋值给record类型外,  其它只能转换到本身，且不能将nil赋值给nil
 */
public abstract class Type {
   public Type actual() {return this;}
   public boolean coerceTo(Type t) {return false;}
}


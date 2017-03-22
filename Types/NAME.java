package Types;
/*
NAME 类型:它用来表示一种未知的类型.而真正的类型需要用binding方法绑定到NAME类型中。需要得到实际类型,应用NAME.actual方法.
 */
public class NAME extends Type {

    public Symbol.Symbol name;
    private Type binding; // 实际的绑定类型

    public NAME(Symbol.Symbol n) {name=n;}

    public boolean isLoop() {
        //去循环
        Type b = binding;
        boolean any;
        binding=null;
        if (b==null) any=true; //如果又出现了这种状态,则循环引用了
        else if (b instanceof NAME) //如果接下来还是NAME类型,继续进入循环
            any=((NAME)b).isLoop();
        else any=false;
        binding=b;
        return any;
    }

    public Type actual() {return binding.actual();}

    public boolean coerceTo(Type t) {
           return this.actual().coerceTo(t);
    }
    public void bind(Type t) {binding = t;}
}

package Types;

public class ARRAY extends Type {
   public Type element;
   public ARRAY(Type e) {element = e;}
   public boolean coerceTo(Type t) {
	if (t.actual() instanceof ARRAY )
//		if (((ARRAY)t).element.coerceTo(this.element))
		return true;
	return false;
   }
}


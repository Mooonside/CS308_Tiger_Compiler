package semant;

import Translate.Exp;
import Types.Type;
public class ExpTy {
		Exp exp; //由translate翻译得到
		Type ty; //由Semant给出
		ExpTy(Exp exp, Type ty) {
		this.exp = exp;
		this.ty = ty;
		}
}

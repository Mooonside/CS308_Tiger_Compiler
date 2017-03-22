package Assem;

public abstract class Instr {
  public String assem;
  public abstract Temp.TempList use();
  public abstract Temp.TempList def();
  public abstract Targets jumps();

  private Temp.Temp nthTemp(Temp.TempList l, int i) {
    if (i==0) return l.head;
    else return nthTemp(l.tail,i-1);
  }

  private Temp.Label nthLabel(Temp.LabelList l, int i) {
    if (i==0) return l.head;
    else return nthLabel(l.tail,i-1);
  }

  public String format(Temp.TempMap m) {
	//将类mips语句中标志源寄存器和目标寄存器的中间表示翻译成真正的寄存器名称，并且此时m中的寄存器已经过分配处理
    Temp.TempList dst = def();
    Temp.TempList src = use();
    Targets j = jumps();
    Temp.LabelList jump = (j==null)?null:j.labels;
    StringBuffer s = new StringBuffer();
    int len = assem.length();
    for(int i=0; i<len; i++)
    {
    	if (assem.charAt(i)=='`')
    		switch(assem.charAt(++i))
    		   {
    	          case 's': {int n = Character.digit(assem.charAt(++i),10);
    				 s.append(m.tempMap(nthTemp(src,n)));
    				 //source
    				}
    				break;
    		      case 'd': {int n = Character.digit(assem.charAt(++i),10);
    				 s.append(m.tempMap(nthTemp(dst,n)));
    				 //dest
    				}
    	 			break;
    		      case 'j': {int n = Character.digit(assem.charAt(++i),10);
    				 s.append(nthLabel(jump,n).toString());
    				 //翻译无条件跳转语句,后接label
    				}
    	 			break;
    	          default: throw new Error("bad Assem format");
    	       }
       else s.append(assem.charAt(i));
    }
    return s.toString();
  }


}

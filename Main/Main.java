package Main;
import java.io.*;
import Absyn.*;
import RegAlloc.RegAlloc;
import semant.*;
import tiger.parse.*;
import tiger.errormsg.*;

public class Main{
    static java.io.PrintStream irOut;

	public static void main(String[] argv) throws java.io.IOException
    {
        String filename = "queens.txt";
       //String filename = "./Testcases/Official/Good/merge.tig";
       //String filename = "./Testcases/Official/Bad/test17.tig";
        ErrorMsg errorMsg = new ErrorMsg(filename);
        //输入
        java.io.FileInputStream input = new java.io.FileInputStream(filename);
        //汇编代码输出
        java.io.PrintStream code_out = new java.io.PrintStream(new java.io.FileOutputStream(filename + ".s"));
        //词法结果输出
        PrintStream lexer_file = new PrintStream(new File(filename+"_lexer_result.txt"));
        //生成词法分析器
        tiger.parse.Lexer lexer = new Yylex(input, errorMsg);
        java_cup.runtime.Symbol tok;
        //词法分析
        System.out.println("lexer result: \n");
        try {
            do{
                tok=lexer.nextToken();
                System.out.println(Dict_lexer[tok.sym] + " " + tok.left);
                lexer_file.println(Dict_lexer[tok.sym] + " " + tok.left);
            }
            while (tok.sym != sym.EOF);
            input.close();
            lexer_file.close();
        }
        catch(Exception e) {
            e.printStackTrace();
        }

        //语法分析
        boolean parse_success = true;
        System.out.println("\n parse result: \n");
        try{
            input = new java.io.FileInputStream(filename);
        }
        catch (java.io.FileNotFoundException e) {
        	code_out.close();
            throw new Error("File not found: " + filename);
        }
        //构造语法分析器
        parser p = new parser( new Yylex(input, errorMsg), errorMsg);
        Print parser_print = new Print(System.out);
        try{
            p.parse();
            Exp exp = p.parseResult;
            parser_print.prExp(exp, 0);
        }
        catch (Exception e){
            e.printStackTrace();
            parse_success=false;
        }
        System.out.println();
        
         //语义分析+翻译树生成 
        if(parse_success){
        Frame.Frame frame = new Mips.MipsFrame();
        Translate.Translate translator = new Translate.Translate(frame);
        Semant smt = new Semant(translator, errorMsg);
        //翻译成段链表
        Frag.Frag frags = smt.transProg(p.parseResult);
        if(ErrorMsg.anyErrors==true) 
        	return;
        System.out.println("\n No Semant error  found ! \n");
        irOut = new java.io.PrintStream(new java.io.FileOutputStream(filename + ".ir")); 
        //若无错误将开始代码生成 
        code_out.println(".globl main");
        for(Frag.Frag f = frags; f!=null; f=f.next)
            if (f instanceof Frag.ProcFrag)
            	//若为程序段则翻译为以.text为开头的汇编代码
                emitProc(code_out, (Frag.ProcFrag)f);
            else if (f instanceof Frag.DataFrag)
            	//若为数据段则翻译为以.data开头的数据或字符串
            	code_out.print("\n.data\n" +((Frag.DataFrag)f).data);
        
        java.io.BufferedReader buffer = 
        		new java.io.BufferedReader(new java.io.InputStreamReader(new java.io.FileInputStream("runtime.s")));
        String data = null;
        while((data = buffer.readLine())!=null) {
        	code_out.println(data);
        }
        //将runtime.s中的库函数汇编代码接到文件末尾
        System.out.println("Translation finished！ \n");
        code_out.close();
        }
        else{
        	System.out.println("due to parser errror,semant examine stopped!");
        }
    }
    static void emitProc(java.io.PrintStream out, Frag.ProcFrag f)
    {
        Tree.Print print = new Tree.Print(irOut);
        //规范化
        Tree.StmList stms = Canon.Canon.linearize(f.body);
        //划分基本块
        Canon.BasicBlocks b = new Canon.BasicBlocks(stms);
         //基本块排序
        Tree.StmList traced = (new Canon.TraceSchedule(b)).stms;
       //打印规范化后的IR树
        prStmList(print,traced);
        //生成汇编代码
        Assem.InstrList instrs = codegen(f.frame, traced);
        instrs = f.frame.procEntryExit2(instrs);
        //寄存器分配
        RegAlloc regAlloc = new RegAlloc(f.frame, instrs);
        instrs = f.frame.procEntryExit3(instrs);
        //将分配寄存器写回汇编指令
        Temp.TempMap tempmap = new Temp.CombineMap(f.frame, regAlloc);
        //以下生成MIPS指令
        out.println("\n.text");
        for (Assem.InstrList p = instrs; p != null; p = p.tail)
            out.println(p.head.format(tempmap));
    }
    
    //打印表达式列表的函数
    static void prStmList(Tree.Print print, Tree.StmList stms)
    {
        for(Tree.StmList l = stms; l!=null; l=l.tail)
            print.prStm(l.head);
    }
    //由中间表示树的表达式列表产生指令列表,按层次依次调用各级codegen
    static Assem.InstrList codegen(Frame.Frame f, Tree.StmList stms)
    {
        Assem.InstrList first = null, last = null;
        for(Tree.StmList s = stms; s != null; s = s.tail)
        {
            Assem.InstrList i = f.codegen(s.head);
            if (last == null)
            {	first = last = i;	}
            else
            {
                while (last.tail != null)
                    last = last.tail;
                last = last.tail = i;
            }
        }
        return first;
    }
    //用于输出词法分析的字符串表
    static String Dict_lexer[] = new String[100];
    static {
        Dict_lexer[sym.FUNCTION] = "FUNCTION";
        Dict_lexer[sym.NUM] = "INT";
        Dict_lexer[sym.STR] = "STRING";
        Dict_lexer[sym.ID] = "ID";
        Dict_lexer[sym.TYPE] = "TYPE";
        Dict_lexer[sym.VAR] = "VAR";
        Dict_lexer[sym.ARRAY] = "ARRAY";
        Dict_lexer[sym.ASSIGN] = "ASSIGN";
        Dict_lexer[sym.IF] = "IF";
        Dict_lexer[sym.THEN] = "THEN";
        Dict_lexer[sym.ELSE] = "ELSE";
        Dict_lexer[sym.DO] = "DO";
        Dict_lexer[sym.WHILE] = "WHILE";
        Dict_lexer[sym.LET] = "LET";
        Dict_lexer[sym.IN] = "IN";
        Dict_lexer[sym.END] = "END";
        Dict_lexer[sym.FOR] = "FOR";
        Dict_lexer[sym.OF] = "OF";
        Dict_lexer[sym.TO] = "TO";
        Dict_lexer[sym.BREAK] = "BREAK";
        Dict_lexer[sym.PLUS] = "PLUS";
        Dict_lexer[sym.MINUS] = "MINUS";
        Dict_lexer[sym.TIMES] = "TIMES";
        Dict_lexer[sym.DIVIDE] = "DIVIDE";
        Dict_lexer[sym.EQ] = "EQ";
        Dict_lexer[sym.NEQ] = "NEQ";
        Dict_lexer[sym.AND] = "AND";
        Dict_lexer[sym.OR] = "OR";
        Dict_lexer[sym.LT] = "LT";
        Dict_lexer[sym.LE] = "LE";
        Dict_lexer[sym.GT] = "GT";
        Dict_lexer[sym.GE] = "GE";
        Dict_lexer[sym.COLON] = "COLON";
        Dict_lexer[sym.COMMA] = "COMMA";
        Dict_lexer[sym.DOT] = "DOT";
        Dict_lexer[sym.SEMICOLON] = "SEMICOLON";
        Dict_lexer[sym.LPAREN] = "LPAREN";
        Dict_lexer[sym.RPAREN] = "RPAREN";
        Dict_lexer[sym.LBRACK] = "LBRACK";
        Dict_lexer[sym.RBRACK] = "RBRACK";
        Dict_lexer[sym.LBRACE] = "LBRACE";
        Dict_lexer[sym.RBRACE] = "RBRACE";
        Dict_lexer[sym.EOF] = "EOF";
        Dict_lexer[sym.NIL] = "NIL";
        Dict_lexer[sym.error] = "error";
    }
}

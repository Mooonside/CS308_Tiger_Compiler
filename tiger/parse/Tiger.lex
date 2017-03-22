package tiger.parse;
import tiger.errormsg.ErrorMsg;
%% 

%implements Lexer
%function nextToken 
%type java_cup.runtime.Symbol 
%char

%{

private void newline() {
  errorMsg.newline(yychar);
}

private void err(int pos, String s) {
	errorMsg.error(pos, s);
}

private void err(String s) {
	err(yychar, s);
}

private java_cup.runtime.Symbol tok(int kind, Object value) {    
	return new java_cup.runtime.Symbol(kind, yychar, yychar+yylength(), value);
}

public Yylex(java.io.InputStream s, ErrorMsg e) {
  this(s);
  errorMsg = e;
}

private ErrorMsg errorMsg;

int comment_count = 0;

StringBuffer string = new StringBuffer();


%}

%eofval{
{ 

	{if( yystate () == COMMENT ) err("MIissing end of comment!");
	if( yystate() == STRING ) err("Missing end of string!");
	if( yystate() == CONTSTRING ) err("Missing end of /.../!");
	return tok(sym.EOF, null);
	}
}
%eofval}       

LineTerminator = \r|\n|\r\n|\n\r
WhiteSpace = [ \t\f]
letter = [a-zA-Z]
digit = [0-9]
Integer = {digit}+
Identifiers = {letter}({digit}|{letter}|_)*

%state COMMENT
%state STRING
%state CONTSTRING


%%

<YYINITIAL> {
	{WhiteSpace}	{ /* do nothing */ }
	{LineTerminator}	{newline();}
	/* Token : Keywords */
	"if"  		{ return tok(sym.IF, null); }
	"for"  		{ return tok(sym.FOR, null); }
	"function" 	{ return tok(sym.FUNCTION, null); }
	"var"		{ return tok(sym.VAR, null); }
	"else"		{ return tok(sym.ELSE, null); }
	"do"		{ return tok(sym.DO, null); }
	"break"		{ return tok(sym.BREAK, null); }
	"end"		{ return tok(sym.END, null); }
	"of"		{ return tok(sym.OF, null); }
	"in"		{ return tok(sym.IN, null); }
	"end"		{ return tok(sym.END, null); }
	"then" 		{ return tok(sym.THEN, null); }
	"nil"		{ return tok(sym.NIL, null); }
	"type"		{ return tok(sym.TYPE, null); }
	"array"		{ return tok(sym.ARRAY, null); }
	"to"		{ return tok(sym.TO, null); }
	"let"		{ return tok(sym.LET, null); }
	"while" 		{return tok(sym.WHILE,null);}
	
	/* Token : Identifiers */
	{Identifiers} 	{ return tok(sym.ID, yytext()); }
	
	/* Token : Integer */
	// should we check very long integer in there?
	{Integer} 	{ return tok(sym.NUM, new Integer(yytext())); }
	
	/* Token : String */
  	\" 		{ {string.setLength(0);yybegin(STRING);} }

  	/* Comment */
  	"/*" 		{comment_count = 1;yybegin(COMMENT); }
  	"*/"		{err("missing start of comment!");}
  	
  	/* Token : SEPARATORS AND OPERATORS */
	","		{ return tok(sym.COMMA, null); }
	":"		{ return tok(sym.COLON, null); }
	";"		{ return tok(sym.SEMICOLON, null); }
	"("		{ return tok(sym.LPAREN, null); }
	")"		{ return tok(sym.RPAREN, null); }
	"["		{ return tok(sym.LBRACK, null); }
	"]"		{ return tok(sym.RBRACK, null); }
	"{"		{ return tok(sym.LBRACE, null); }
	"}"		{ return tok(sym.RBRACE, null); }
	"."		{ return tok(sym.DOT, null); }
	"+"		{ return tok(sym.PLUS, null); }
	"-"		{ return tok(sym.MINUS, null); }
	"*"		{ return tok(sym.TIMES, null); }
	"/"		{ return tok(sym.DIVIDE, null); }
	"="		{ return tok(sym.EQ, null); }
	"<>"		{ return tok(sym.NEQ, null); }
	"<"		{ return tok(sym.LT, null); }
	"<="		{ return tok(sym.LE, null); }
	">"		{ return tok(sym.GT, null); }
	">="		{ return tok(sym.GE, null); }
	"&"		{ return tok(sym.AND, null); }
	"|"		{ return tok(sym.OR, null); }
	":="		{ return tok(sym.ASSIGN, null); }
	[^] 		{ err("illegal ch!");return tok(sym.error, yytext()); }
}

<COMMENT> {
	[^] 	{ /* nothing*/ }
	"/*" 	{comment_count += 1;}
	"*/"	{comment_count -= 1;if(comment_count==0) yybegin(YYINITIAL);}
}

<STRING>{
	\"			{yybegin(YYINITIAL);return tok(sym.STR,string.toString());}
	[^\n\r\"\\]+ 		{string.append(yytext());}
	\\t 			{string.append('\t');}
	\\n 			{string.append('\n');}
	\\r 			{string.append('\r');}
	\\\" 			{string.append('\"');}
	\\\\ 			{string.append('\\');} 
	\\{digit}{digit}{digit}	{int temp=Integer.parseInt(yytext().substring(1, 4));
				if(temp>255) 
					err("excessive ASCII range"); 
				else 
					string.append((char)temp); }
	{LineTerminator}	{err("String have a terminator inside! ");}
	\\			{yybegin(CONTSTRING);}			
}

<CONTSTRING>{
	{WhiteSpace}		{}
	{LineTerminator}	{}
	\\			{yybegin(STRING);}
	\"			{err("not match /.../!");}
	[^]			{string.append(yytext());}			
}

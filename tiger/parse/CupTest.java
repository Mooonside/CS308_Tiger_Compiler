package tiger.parse;

import java.io.FileInputStream;

import java.io.FileNotFoundException;
import java.io.InputStream;
import tiger.errormsg.ErrorMsg;

public class CupTest {

	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
	public static void main(String[] args) throws FileNotFoundException {
		String filename = "cuptest.txt";
		ErrorMsg errorMsg = new ErrorMsg(filename);
		InputStream inp = new FileInputStream(filename);
		Yylex lexer = new Yylex(inp, errorMsg);
		parser p = new parser(lexer,errorMsg);
		try {
			p.parse();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

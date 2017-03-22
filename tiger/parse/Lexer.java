package tiger.parse;

public interface Lexer {
    public java_cup.runtime.Symbol nextToken() throws java.io.IOException;
}

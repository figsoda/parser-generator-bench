import org.antlr.v4.runtime.*;
import java.io.Console;

class Main {
    public static void main(String[] args) {
        Console c = System.console();
        for(;;) {
            calcParser parser = new calcParser(new CommonTokenStream(new calcLexer(CharStreams.fromString(c.readLine()))));
            parser.setErrorHandler(new BailErrorStrategy());
            parser.expr();
        }
    }
}

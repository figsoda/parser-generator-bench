import org.antlr.v4.runtime.*;
import java.util.Scanner;

class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while(scanner.hasNext()) {
            calcParser parser = new calcParser(new CommonTokenStream(new calcLexer(CharStreams.fromString(scanner.nextLine()))));
            parser.setErrorHandler(new BailErrorStrategy());
            parser.expr();
        }
        scanner.close();
    }
}

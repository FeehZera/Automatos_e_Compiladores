package Prototipos.p1;
import java.io.FileReader;

public class main {
    public static void main(String[] args) {
        try {
            Lexer lexer = new Lexer(new FileReader(args[0]));
            Parser parser = new Parser(lexer);
            parser.parse();
            System.out.println("Parsing completed successfully.");
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("An error occurred: " + e.getMessage());}
    }
}

package ex2;

public class Main {
    public static void main(String[] args) {
        try {
            Lexer lexer = new Lexer("ex2/test.txt");
            Parser parser = new Parser(lexer);
            parser.parse();
            System.out.println("Parsing completed successfully.");
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("An error occurred: " + e.getMessage());}
    }
}

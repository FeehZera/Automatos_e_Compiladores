import java.io.FileReader;

public class Main {

    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("Uso: java Main <arquivo_entrada> <pasta_saida>");
            return;
        }

        String arquivoEntrada = args[0];
        String pastaSaida = args[1];

        try {
            Lexer lexer = new Lexer(new FileReader(arquivoEntrada));
            parser parser = new parser(lexer);

            parser.parse();

            Semantic semantic = parser.getSemantic();

            semantic.gerarTodosProfiles(pastaSaida);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

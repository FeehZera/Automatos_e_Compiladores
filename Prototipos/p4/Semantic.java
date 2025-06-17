import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class Semantic {

    private Map<String, Profile> profiles = new LinkedHashMap<>();

    public static class Profile {
        public String nome;
        public List<String> comandos = new ArrayList<>();
        public Map<String, Var> vars = new LinkedHashMap<>();
        public Map<String, String> binds = new LinkedHashMap<>();

        public Profile(String nome) {
            this.nome = nome;
        }
    }

    public static class Var {
        public String nome;
        public List<String> comandos = new ArrayList<>();

        public Var(String nome) {
            this.nome = nome;
        }
    }

    public void addProfile(Profile p) {
        profiles.put(p.nome, p);
    }

    public void gerarArquivoCFG(String nomeProfile, String caminhoArquivo) throws IOException {
        Profile p = profiles.get(nomeProfile);
        if (p == null) {
            System.err.println("Profile não encontrado: " + nomeProfile);
            return;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(caminhoArquivo))) {
            bw.write("// Arquivo .cfg para profile: " + p.nome + "\n\n");

            for (String cmd : p.comandos) {
                bw.write(cmd + "\n");
            }

            bw.write("\n// Variáveis (vars)\n");
            for (Var v : p.vars.values()) {
                bw.write("// Var: " + v.nome + "\n");
                for (String cmd : v.comandos) {
                    bw.write(cmd + "\n");
                }
                bw.write("\n");
            }

            bw.write("// Binds\n");
            for (Map.Entry<String,String> bind : p.binds.entrySet()) {
                bw.write("bind \"" + bind.getKey() + "\" \"" + bind.getValue() + "\"\n");
            }
        }
        System.out.println("Arquivo gerado: " + caminhoArquivo);
    }

    public void gerarTodosProfiles(String pastaSaida) throws IOException {
        for (String nome : profiles.keySet()) {
            gerarArquivoCFG(nome, pastaSaida + "/" + nome + ".cfg");
        }
    }
}

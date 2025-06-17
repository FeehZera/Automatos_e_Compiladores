package Prototipos.p8;

import java.io.*;
import java.util.*;

public class Main {
    
    public static void main(String[] args) {
        System.out.println("==========================================");
        System.out.println("    CS2 Config Language Compiler v1.0    ");
        System.out.println("==========================================\n");
        
        // Verificar argumentos
        if (args.length == 0) {
            printUsage();
            return;
        }
        
        String inputFile = args[0];
        boolean verbose = Arrays.asList(args).contains("-v") || Arrays.asList(args).contains("--verbose");
        boolean debug = Arrays.asList(args).contains("-d") || Arrays.asList(args).contains("--debug");
        
        try {
            // Compilar o arquivo
            compileFile(inputFile, verbose, debug);
            
        } catch (Exception e) {
            System.err.println("ERRO FATAL: " + e.getMessage());
            if (debug) {
                e.printStackTrace();
            }
            System.exit(1);
        }
    }
    
    private static void printUsage() {
        System.out.println("Uso: java Main <arquivo.cs2> [opções]");
        System.out.println();
        System.out.println("Opções:");
        System.out.println("  -v, --verbose    Modo verboso (mostra detalhes da compilação)");
        System.out.println("  -d, --debug      Modo debug (mostra stack trace dos erros)");
        System.out.println("  -h, --help       Mostra esta ajuda");
        System.out.println();
        System.out.println("Exemplo:");
        System.out.println("  java Main config.cs2");
        System.out.println("  java Main config.cs2 -v");
        System.out.println();
        System.out.println("O compilador irá gerar arquivos .cfg para cada perfil definido.");
    }
    
    private static void compileFile(String inputFile, boolean verbose, boolean debug) throws Exception {
        // Verificar se o arquivo existe
        File file = new File(inputFile);
        if (!file.exists()) {
            throw new FileNotFoundException("Arquivo não encontrado: " + inputFile);
        }
        
        if (verbose) {
            System.out.println("📂 Compilando arquivo: " + inputFile);
            System.out.println("📊 Tamanho do arquivo: " + file.length() + " bytes");
            System.out.println();
        }
        
        // Fase 1: Análise Léxica
        if (verbose) System.out.println("🔍 Fase 1: Análise Léxica...");
        
        FileReader reader = new FileReader(inputFile);
        Lexer lexer = new Lexer(reader);
        
        if (debug) {
            System.out.println("   Tokens encontrados:");
            testLexer(inputFile);
        }
        
        // Fase 2: Análise Sintática e Semântica
        if (verbose) System.out.println("⚙️  Fase 2: Análise Sintática e Semântica...");
        
        reader = new FileReader(inputFile); // Reabrir o arquivo
        lexer = new Lexer(reader);
        parser parser = new parser(lexer);
        
        // Executar o parser
        try {
            parser.parse();
            if (verbose) System.out.println("✅ Análise sintática concluída com sucesso!");
        } catch (Exception e) {
            System.err.println("❌ Erro durante a análise sintática:");
            System.err.println("   " + e.getMessage());
            throw e;
        }
        
        // Fase 3: Validação Semântica
        if (verbose) System.out.println("🔬 Fase 3: Validação Semântica...");
        
        Semantic semantic = parser.getSemantic();
        semantic.validate();
        
        // Verificar erros semânticos
        if (semantic.hasErrors()) {
            System.err.println("❌ Erros semânticos encontrados:");
            for (String error : semantic.getErrors()) {
                System.err.println("   • " + error);
            }
            throw new RuntimeException("Compilação falhou devido a erros semânticos");
        }
        
        if (verbose) {
            System.out.println("✅ Validação semântica concluída!");
            semantic.printProfilesInfo();
        }
        
        // Fase 4: Geração de Código
        if (verbose) System.out.println("🏗️  Fase 4: Geração de arquivos .cfg...");
        
        semantic.generateConfigs();
        
        System.out.println("🎉 Compilação concluída com sucesso!");
        System.out.println("   Os arquivos .cfg foram gerados no diretório atual.");
        
        reader.close();
    }
    
    // Método para testar o lexer (modo debug)
    private static void testLexer(String inputFile) {
        try {
            FileReader reader = new FileReader(inputFile);
            Lexer lexer = new Lexer(reader);
            
            java_cup.runtime.Symbol token;
            int tokenCount = 0;
            
            while (!lexer.zzAtEOF) {
                token = lexer.next_token();
                if (token.sym != sym.EOF) {
                    tokenCount++;
                    System.out.println("   Token " + tokenCount + ": " + 
                                     getTokenName(token.sym) + 
                                     " [" + token.value + "] " +
                                     "(" + (token.left+1) + ":" + (token.right+1) + ")");
                }
                if (token.sym == sym.EOF) break;
            }
            
            System.out.println("   Total de tokens: " + tokenCount);
            System.out.println();
            reader.close();
            
        } catch (Exception e) {
            System.err.println("   Erro no teste do lexer: " + e.getMessage());
        }
    }
    
    // Método auxiliar para obter nome do token (para debug)
    private static String getTokenName(int tokenType) {
        // Mapeamento básico dos tokens mais comuns
        Map<Integer, String> tokenNames = new HashMap<>();
        
        try {
            // Usar reflexão para obter os nomes dos tokens da classe sym
            java.lang.reflect.Field[] fields = sym.class.getDeclaredFields();
            for (java.lang.reflect.Field field : fields) {
                if (java.lang.reflect.Modifier.isStatic(field.getModifiers()) && 
                    java.lang.reflect.Modifier.isFinal(field.getModifiers()) &&
                    field.getType() == int.class) {
                    try {
                        int value = field.getInt(null);
                        tokenNames.put(value, field.getName());
                    } catch (IllegalAccessException e) {
                        // Ignorar campos inacessíveis
                    }
                }
            }
        } catch (Exception e) {
            // Se a reflexão falhar, usar nomes genéricos
        }
        
        return tokenNames.getOrDefault(tokenType, "TOKEN_" + tokenType);
    }
    
    // Método para criar arquivo de exemplo
    public static void createExampleFile(String filename) {
        try {
            PrintWriter writer = new PrintWriter(new FileWriter(filename));
            
            writer.println("// Arquivo de exemplo da CS2 Config Language");
            writer.println("// Este arquivo demonstra as funcionalidades básicas");
            writer.println();
            writer.println("perfil ProPlayer {");
            writer.println("    // Configurações básicas");
            writer.println("    fps_max 300;");
            writer.println("    sensibilidade 2.5;");
            writer.println("    console 1;");
            writer.println("    ");
            writer.println("    // Configurações de mira");
            writer.println("    estilo_mira 4;");
            writer.println("    tamanho_mira 3;");
            writer.println("    cor_mira 1;");
            writer.println("    ");
            writer.println("    // Binds básicos");
            writer.println("    tecla w +frente;");
            writer.println("    tecla s +tras;");
            writer.println("    tecla a +esquerda;");
            writer.println("    tecla d +direita;");
            writer.println("    tecla space +pular;");
            writer.println("    tecla shift +agachar;");
            writer.println("    ");
            writer.println("    // Alias para jumpthrow");
            writer.println("    var jumpthrow {");
            writer.println("        tecla c jumpthrow;");
            writer.println("    }");
            writer.println("    ");
            writer.println("    msg \"Perfil ProPlayer carregado!\";");
            writer.println("}");
            writer.println();
            writer.println("perfil Casual {");
            writer.println("    fps_max 144;");
            writer.println("    sensibilidade 1.8;");
            writer.println("    volume_geral 0.8;");
            writer.println("    ");
            writer.println("    tecla w +frente;");
            writer.println("    tecla s +tras;");
            writer.println("    tecla a +esquerda;");
            writer.println("    tecla d +direita;");
            writer.println("    ");
            writer.println("    msg \"Perfil Casual ativo!\";");
            writer.println("}");
            
            writer.close();
            System.out.println("Arquivo de exemplo criado: " + filename);
            
        } catch (IOException e) {
            System.err.println("Erro ao criar arquivo de exemplo: " + e.getMessage());
        }
    }
    
    // Método para mostrar informações da versão
    private static void showVersion() {
        System.out.println("CS2 Config Language Compiler");
        System.out.println("Versão: 1.0.0");
        System.out.println("Desenvolvido para Counter-Strike 2");
        System.out.println();
        System.out.println("Funcionalidades:");
        System.out.println("• Múltiplos perfis de configuração");
        System.out.println("• Tradução automática para comandos CS2");
        System.out.println("• Validação semântica");
        System.out.println("• Geração de arquivos .cfg otimizados");
        System.out.println("• Suporte a aliases e binds complexos");
    }
}
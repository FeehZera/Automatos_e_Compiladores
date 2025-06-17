package Prototipos.p8;

import java.io.*;
import java.util.*;

public class Semantic {
    
    // Estruturas para armazenar dados dos perfis
    private Map<String, Profile> profiles;
    private Map<String, String> commandMappings;
    private List<String> errors;
    
    public Semantic() {
        this.profiles = new HashMap<>();
        this.errors = new ArrayList<>();
        initializeCommandMappings();
    }
    
    // Classe interna para representar um perfil
    public class Profile {
        public String name;
        public Map<String, String> configs;
        public Map<String, String> binds;
        public Map<String, Alias> aliases;
        public List<String> messages;
        
        public Profile(String name) {
            this.name = name;
            this.configs = new HashMap<>();
            this.binds = new HashMap<>();
            this.aliases = new HashMap<>();
            this.messages = new ArrayList<>();
        }
    }
    
    // Classe interna para aliases
    public class Alias {
        public String name;
        public List<String> commands;
        public Map<String, String> configs;
        public Map<String, String> binds;
        
        public Alias(String name) {
            this.name = name;
            this.commands = new ArrayList<>();
            this.configs = new HashMap<>();
            this.binds = new HashMap<>();
        }
    }
    
    // Inicializa mapeamento de comandos da linguagem para CS2
    private void initializeCommandMappings() {
        commandMappings = new HashMap<>();
        
        // Configurações básicas
        commandMappings.put("gama", "r_fullscreen_gamma");
        commandMappings.put("fps_max", "fps_max");
        commandMappings.put("console", "con_enable");
        commandMappings.put("sensibilidade", "sensitivity");
        commandMappings.put("sensibilidade_zoom", "zoom_sensitivity_ratio");
        
        // Configurações de HUD
        commandMappings.put("escala_hud", "hud_scaling");
        commandMappings.put("id_inimigo", "hud_showtargetid");
        commandMappings.put("cor_hud", "cl_hud_color");
        
        // Configurações de radar
        commandMappings.put("radar_escala", "cl_hud_radar_scale");
        commandMappings.put("radar_escala_interno", "cl_radar_scale");
        commandMappings.put("radar_centralizado", "cl_radar_always_centered");
        commandMappings.put("rotar_radar", "cl_radar_rotate");
        
        // Configurações de mira
        commandMappings.put("contorno_mira", "cl_crosshair_drawoutline");
        commandMappings.put("estilo_mira", "cl_crosshairstyle");
        commandMappings.put("tamanho_mira", "cl_crosshairsize");
        commandMappings.put("espessura_mira", "cl_crosshairthickness");
        commandMappings.put("espacamento_mira", "cl_crosshairgap");
        commandMappings.put("cor_mira", "cl_crosshaircolor");
        commandMappings.put("transparencia_mira", "cl_crosshairalpha");
        
        // Configurações de áudio
        commandMappings.put("volume_geral", "volume");
        commandMappings.put("volume_menu", "snd_menumusic_volume");
        commandMappings.put("volume_mvp", "snd_mvp_volume");
        commandMappings.put("volume_voip", "snd_voipvolume");
        
        // Ações de movimento
        commandMappings.put("+frente", "+forward");
        commandMappings.put("-frente", "-forward");
        commandMappings.put("+tras", "+back");
        commandMappings.put("-tras", "-back");
        commandMappings.put("+esquerda", "+moveleft");
        commandMappings.put("-esquerda", "-moveleft");
        commandMappings.put("+direita", "+moveright");
        commandMappings.put("-direita", "-moveright");
        commandMappings.put("+pular", "+jump");
        commandMappings.put("-pular", "-jump");
        commandMappings.put("+agachar", "+duck");
        commandMappings.put("-agachar", "-duck");
        commandMappings.put("+atacar", "+attack");
        commandMappings.put("-atacar", "-attack");
        commandMappings.put("+atacar2", "+attack2");
        commandMappings.put("-atacar2", "-attack2");
        commandMappings.put("+usar", "+use");
        commandMappings.put("-usar", "-use");
        commandMappings.put("+recarregar", "+reload");
        commandMappings.put("-recarregar", "-reload");
        commandMappings.put("+mic", "+voicerecord");
        commandMappings.put("-mic", "-voicerecord");
        commandMappings.put("+placar", "+showscores");
        commandMappings.put("-placar", "-showscores");
        
        // Slots de armas
        for(int i = 1; i <= 10; i++) {
            commandMappings.put("slot" + i, "slot" + i);
        }
        
        // Comandos especiais
        commandMappings.put("jumpthrow", "jumpthrow"); // Será expandido como alias
    }
    
    // Métodos chamados pelo parser
    public void startProfile(String profileName) {
        if (profiles.containsKey(profileName)) {
            addError("Perfil '" + profileName + "' já existe");
            return;
        }
        profiles.put(profileName, new Profile(profileName));
    }
    
    public void addConfig(String profileName, String configName, String value) {
        Profile profile = profiles.get(profileName);
        if (profile == null) {
            addError("Perfil '" + profileName + "' não encontrado");
            return;
        }
        
        String cs2Command = commandMappings.get(configName);
        if (cs2Command == null) {
            addError("Comando de configuração '" + configName + "' não reconhecido");
            return;
        }
        
        profile.configs.put(cs2Command, value);
    }
    
    public void addBind(String profileName, String key, String action) {
        Profile profile = profiles.get(profileName);
        if (profile == null) {
            addError("Perfil '" + profileName + "' não encontrado");
            return;
        }
        
        // Verificar se a tecla já está vinculada
        if (profile.binds.containsKey(key)) {
            addError("Tecla '" + key + "' já está vinculada no perfil '" + profileName + "'");
            return;
        }
        
        String cs2Action = translateAction(action);
        profile.binds.put(key, cs2Action);
    }
    
    public void startAlias(String profileName, String aliasName) {
        Profile profile = profiles.get(profileName);
        if (profile == null) {
            addError("Perfil '" + profileName + "' não encontrado");
            return;
        }
        
        if (profile.aliases.containsKey(aliasName)) {
            addError("Alias '" + aliasName + "' já existe no perfil '" + profileName + "'");
            return;
        }
        
        profile.aliases.put(aliasName, new Alias(aliasName));
    }
    
    public void addAliasConfig(String profileName, String aliasName, String configName, String value) {
        Profile profile = profiles.get(profileName);
        if (profile == null) return;
        
        Alias alias = profile.aliases.get(aliasName);
        if (alias == null) return;
        
        String cs2Command = commandMappings.get(configName);
        if (cs2Command != null) {
            alias.configs.put(cs2Command, value);
        }
    }
    
    public void addAliasBind(String profileName, String aliasName, String key, String action) {
        Profile profile = profiles.get(profileName);
        if (profile == null) return;
        
        Alias alias = profile.aliases.get(aliasName);
        if (alias == null) return;
        
        String cs2Action = translateAction(action);
        alias.binds.put(key, cs2Action);
    }
    
    public void addMessage(String profileName, String message) {
        Profile profile = profiles.get(profileName);
        if (profile == null) return;
        
        profile.messages.add(message);
    }
    
    // Traduz ações da linguagem para CS2
    private String translateAction(String action) {
        // Verificar se é um comando especial como jumpthrow
        if (action.equals("jumpthrow")) {
            return "jumpthrow"; // Será expandido posteriormente
        }
        
        String cs2Action = commandMappings.get(action);
        return cs2Action != null ? cs2Action : action;
    }
    
    // Gera os arquivos .cfg
    public void generateConfigs() {
        for (Profile profile : profiles.values()) {
            generateConfigFile(profile);
        }
    }
    
    private void generateConfigFile(Profile profile) {
        try {
            String filename = profile.name.toLowerCase() + ".cfg";
            PrintWriter writer = new PrintWriter(new FileWriter(filename));
            
            // Header do arquivo
            writer.println("// ===============================================");
            writer.println("// Configuração CS2 - Perfil: " + profile.name);
            writer.println("// Gerado automaticamente pela CS2 Config Language");
            writer.println("// ===============================================");
            writer.println();
            
            // Configurações básicas
            if (!profile.configs.isEmpty()) {
                writer.println("// === CONFIGURAÇÕES ===");
                for (Map.Entry<String, String> config : profile.configs.entrySet()) {
                    writer.println(config.getKey() + " " + config.getValue());
                }
                writer.println();
            }
            
            // Binds
            if (!profile.binds.isEmpty()) {
                writer.println("// === BINDS ===");
                for (Map.Entry<String, String> bind : profile.binds.entrySet()) {
                    String key = bind.getKey();
                    String action = bind.getValue();
                    
                    // Expandir comandos especiais
                    if (action.equals("jumpthrow")) {
                        writer.println("alias jumpthrow \"+jump; -attack; -jump\"");
                        writer.println("bind " + key + " jumpthrow");
                    } else {
                        writer.println("bind " + key + " \"" + action + "\"");
                    }
                }
                writer.println();
            }
            
            // Aliases
            if (!profile.aliases.isEmpty()) {
                writer.println("// === ALIASES ===");
                for (Alias alias : profile.aliases.values()) {
                    generateAlias(writer, alias);
                }
                writer.println();
            }
            
            // Mensagens
            if (!profile.messages.isEmpty()) {
                writer.println("// === MENSAGENS ===");
                for (String message : profile.messages) {
                    writer.println("echo " + message);
                }
                writer.println();
            }
            
            // Footer
            writer.println("// === FIM DA CONFIGURAÇÃO ===");
            writer.println("echo \"Perfil " + profile.name + " carregado com sucesso!\"");
            writer.println("host_writeconfig");
            
            writer.close();
            System.out.println("Arquivo " + filename + " gerado com sucesso!");
            
        } catch (IOException e) {
            addError("Erro ao gerar arquivo para perfil '" + profile.name + "': " + e.getMessage());
        }
    }
    
    private void generateAlias(PrintWriter writer, Alias alias) {
        writer.println("// Alias: " + alias.name);
        
        // Primeiro, definir configurações do alias se houver
        for (Map.Entry<String, String> config : alias.configs.entrySet()) {
            writer.println(config.getKey() + " " + config.getValue());
        }
        
        // Depois, binds do alias
        for (Map.Entry<String, String> bind : alias.binds.entrySet()) {
            writer.println("bind " + bind.getKey() + " \"" + bind.getValue() + "\"");
        }
        
        // Criar o alias propriamente dito se necessário
        if (!alias.commands.isEmpty()) {
            writer.print("alias " + alias.name + " \"");
            writer.print(String.join("; ", alias.commands));
            writer.println("\"");
        }
        
        writer.println();
    }
    
    // Gerenciamento de erros
    private void addError(String error) {
        errors.add(error);
        System.err.println("ERRO SEMÂNTICO: " + error);
    }
    
    public List<String> getErrors() {
        return new ArrayList<>(errors);
    }
    
    public boolean hasErrors() {
        return !errors.isEmpty();
    }
    
    // Método para debug
    public void printProfilesInfo() {
        System.out.println("=== INFORMAÇÕES DOS PERFIS ===");
        for (Profile profile : profiles.values()) {
            System.out.println("Perfil: " + profile.name);
            System.out.println("  Configurações: " + profile.configs.size());
            System.out.println("  Binds: " + profile.binds.size());
            System.out.println("  Aliases: " + profile.aliases.size());
            System.out.println("  Mensagens: " + profile.messages.size());
            System.out.println();
        }
    }
    
    // Validações adicionais
    public void validate() {
        for (Profile profile : profiles.values()) {
            validateProfile(profile);
        }
    }
    
    private void validateProfile(Profile profile) {
        // Verificar conflitos de binds
        Set<String> usedKeys = new HashSet<>();
        
        // Verificar binds do perfil
        for (String key : profile.binds.keySet()) {
            if (usedKeys.contains(key)) {
                addError("Tecla '" + key + "' está duplicada no perfil '" + profile.name + "'");
            }
            usedKeys.add(key);
        }
        
        // Verificar binds dos aliases
        for (Alias alias : profile.aliases.values()) {
            for (String key : alias.binds.keySet()) {
                if (usedKeys.contains(key)) {
                    addError("Tecla '" + key + "' no alias '" + alias.name + "' conflita com outro bind no perfil '" + profile.name + "'");
                }
                usedKeys.add(key);
            }
        }
    }
}
import java_cup.runtime.*;
%%
%class Lexer
%implements java_cup.runtime.Scanner
%unicode
%public
%cup

// ======= MACROS =======

// Espaços e Comentários
WHITESPACE = [ \t\r\n]+
COMMENT    = "//" [^\n]*

// Identificadores e Números
NUMBER     = [0-9]+(\.[0-9]+)?
ID         = [a-zA-Z_][a-zA-Z0-9_]*

// Teclas Suportadas
KEYS = (
    "f1" | "f2" | "f3" | "f4" | "f5" | "f6" | "f7" | "f8" | "f9" | "f10" | "f11" | "f12" |
    "tab" | "enter" | "shift" | "ctrl" | "alt" | "space" |
    "mwheelup" | "mwheeldown" |
    "leftarrow" | "rightarrow" | "uparrow" | "downarrow" | "mouse1" | "mouse2" | "mouse3" | "mouse4" | "mouse5"
)

// Palavras-chave
KW_CLEAR    = "limpar"
KW_ECHO     = "echo"
KW_PROFILE  = "perfil"
KW_VAR      = "var"
KW_TECLA    = "tecla"

// Delimitadores
QUOTE       = "\""
EQUALS      = "="
SEMICOLON   = ";"
LBRACE      = "{"
RBRACE      = "}"

// Comandos Traduzidos (ações)
CMD_PLUS_JUMP     = "\\+pula"
CMD_MINUS_JUMP    = "\\-pula"
CMD_PLUS_DUCK     = "\\+agacha"
CMD_MINUS_DUCK    = "\\-agacha"
CMD_PLUS_ATTACK   = "\\+atira"
CMD_MINUS_ATTACK  = "\\-atira"
CMD_CROSSHAIR     = "mira"
CMD_COLOR         = "cor"
CMD_SENS          = "sensibilidade"
CMD_SLOT1         = "arma1"
CMD_SLOT2         = "arma2"

%%

// ======= Ignorar Espaços e Comentários =======
{WHITESPACE}      { /* ignora espaços */ }
{COMMENT}         { /* ignora comentários */ }

// ======= Palavras-chave =======
{KW_CLEAR}        { return new Symbol(sym.CLEAR, yyline, yycolumn); }
{KW_ECHO}         { return new Symbol(sym.ECHO, yyline, yycolumn); }
{KW_PROFILE}      { return new Symbol(sym.PROFILE, yyline, yycolumn); }
{KW_VAR}          { return new Symbol(sym.VAR, yyline, yycolumn); }
{KW_TECLA}        { return new Symbol(sym.TECLA, yyline, yycolumn); }

// ======= Comandos Traduzidos =======
{CMD_PLUS_JUMP}   { return new Symbol(sym.JUMP_PLUS, yyline, yycolumn); }
{CMD_MINUS_JUMP}  { return new Symbol(sym.JUMP_MINUS, yyline, yycolumn); }
{CMD_PLUS_DUCK}   { return new Symbol(sym.DUCK_PLUS, yyline, yycolumn); }
{CMD_MINUS_DUCK}  { return new Symbol(sym.DUCK_MINUS, yyline, yycolumn); }
{CMD_PLUS_ATTACK} { return new Symbol(sym.ATTACK_PLUS, yyline, yycolumn); }
{CMD_MINUS_ATTACK}{ return new Symbol(sym.ATTACK_MINUS, yyline, yycolumn); }
{CMD_CROSSHAIR}   { return new Symbol(sym.CROSSHAIR, yyline, yycolumn); }
{CMD_COLOR}       { return new Symbol(sym.COLOR, yyline, yycolumn); }
{CMD_SENS}        { return new Symbol(sym.SENS, yyline, yycolumn); }
{CMD_SLOT1}       { return new Symbol(sym.SLOT1, yyline, yycolumn); }
{CMD_SLOT2}       { return new Symbol(sym.SLOT2, yyline, yycolumn); }

// ======= Valores =======
{KEYS}            { return new Symbol(sym.KEY, yyline, yycolumn, yytext().toUpperCase()); }
{ID}              { return new Symbol(sym.ID, yyline, yycolumn, yytext()); }
{NUMBER}          { return new Symbol(sym.NUMBER, yyline, yycolumn, Double.parseDouble(yytext())); }

// ======= Delimitadores =======
{QUOTE}           { return new Symbol(sym.QUOTE, yyline, yycolumn); }
{EQUALS}          { return new Symbol(sym.EQUALS, yyline, yycolumn); }
{SEMICOLON}       { return new Symbol(sym.SEMICOLON, yyline, yycolumn); }
{LBRACE}          { return new Symbol(sym.LBRACE, yyline, yycolumn); }
{RBRACE}          { return new Symbol(sym.RBRACE, yyline, yycolumn); }

// ======= Erro =======
.                 { System.err.println("Caractere inválido: " + yytext()); return new Symbol(sym.ERROR, yyline, yycolumn); }
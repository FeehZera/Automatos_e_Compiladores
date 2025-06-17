import java_cup.runtime.*;
%%
%class Lexer
%implements java_cup.runtime.Scanner
%unicode
%public
%cup

// Definições (macros, expressões)
WHITESPACE = [ \t\r\n]+
NUMBER     = [0-9]+(\.[0-9]+)?
ID         = [a-zA-Z_][a-zA-Z0-9_]*
KEYS       = ("f1"|"f2"|"f3"|"f4"|"f5"|"f6"|"f7"|"f8"|"f9"|"f10"|"f11"|"f12"|
              "tab"|"enter"|"shift"|"ctrl"|"alt"|"space"|
              "mwheelup"|"mwheeldown"|
              "leftarrow"|"rightarrow"|"uparrow"|"downarrow")

EQUALS     = "="
QUOTE      = "\""
SEMICOLON  = ";"
LBRACE     = "{"
RBRACE     = "}"
COMMENT    = "//" [^\n]*
%%

{WHITESPACE}      { /* ignora espaços e quebras de linha */ }

{COMMENT}         { /* ignora comentários de linha */ }

"clear"           { return new java_cup.runtime.Symbol(sym.CLEAR, yyline, yycolumn); }

"echo"            { return new java_cup.runtime.Symbol(sym.ECHO, yyline, yycolumn); }

"profile"         { return new java_cup.runtime.Symbol(sym.PROFILE, yyline, yycolumn); }

"var"             { return new java_cup.runtime.Symbol(sym.VAR, yyline, yycolumn); }

"tecla"           { return new java_cup.runtime.Symbol(sym.TECLA, yyline, yycolumn); }

{KEYS}            { return new java_cup.runtime.Symbol(sym.KEY, yyline, yycolumn, yytext().toUpperCase()); }

{ID}              { return new java_cup.runtime.Symbol(sym.ID, yyline, yycolumn, yytext()); }

{NUMBER}          { return new java_cup.runtime.Symbol(sym.NUMBER, yyline, yycolumn, Double.parseDouble(yytext())); }

{EQUALS}          { return new java_cup.runtime.Symbol(sym.EQUALS, yyline, yycolumn); }

{QUOTE}           { return new java_cup.runtime.Symbol(sym.QUOTE, yyline, yycolumn); }

{SEMICOLON}       { return new java_cup.runtime.Symbol(sym.SEMICOLON, yyline, yycolumn); }

{LBRACE}          { return new java_cup.runtime.Symbol(sym.LBRACE, yyline, yycolumn); }

{RBRACE}          { return new java_cup.runtime.Symbol(sym.RBRACE, yyline, yycolumn); }

// Qualquer caractere inesperado gera erro
.                 { System.err.println("Caractere inválido: " + yytext()); }


%%

%public
%class Lexer
%unicode
%cup
%line
%column

%{

// Importações opcionais (útil se for usar objetos ou listas de tokens)
import java_cup.runtime.Symbol;

%}

// Definição de macros (atalhos para padrões)
DIGITO     = [0-9]
LETRA      = [a-zA-Z]
ID         = {LETRA}({LETRA}|{DIGITO})*

%%

// Palavras-chave
"if"        { return new Symbol(sym.IF); }
"else"      { return new Symbol(sym.ELSE); }

// Operadores
"="         { return new Symbol(sym.ATRIB); }
"=="        { return new Symbol(sym.IGUAL); }
"+"         { return new Symbol(sym.MAIS); }
"-"         { return new Symbol(sym.MENOS); }

// Símbolos
"("         { return new Symbol(sym.ABRE_PAR); }
")"         { return new Symbol(sym.FECHA_PAR); }

// Identificadores e números
{ID}        { return new Symbol(sym.ID, yyline+1, yycolumn+1, yytext()); }
{DIGITO}+   { return new Symbol(sym.NUM, yyline+1, yycolumn+1, Integer.parseInt(yytext())); }

// Espaços em branco e quebras de linha (ignorados)
[ \t\r\n]+  { /* ignora */ }

// Qualquer coisa inesperada (erro léxico)
.           { System.err.println("Caractere inesperado: " + yytext() + " na linha " + (yyline+1)); }

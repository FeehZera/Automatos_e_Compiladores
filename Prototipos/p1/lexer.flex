
%%

%class Lexer
%unicode
%cup
%line
%column

%{
  package linguagem;
  import java_cup.runtime.Symbol;
%}

/* ========== MACROS ========== */

// Letras e dígitos
L          = [a-zA-Z_]
D          = [0-9]
ID         = {L}({L}|{D})*

// Números
INT        = {D}+
FLOAT      = {D}+"."{D}+

// Operadores aritméticos
PLUS       = "+"
MINUS      = "-"
TIMES      = "*"
DIV        = "/"

// Operadores relacionais
EQ         = "=="
NEQ        = "!="
LE         = "<="
GE         = ">="
LT         = "<"
GT         = ">"

// Atribuição
ASSIGN     = "="

// Delimitadores
SEMI       = ";"
COMMA      = ","
LPAREN     = "("
RPAREN     = ")"
LBRACE     = "{"
RBRACE     = "}"
LBRACKET   = "\["
RBRACKET   = "\]"

// Comentários
LINE_COMMENT = "//".*
BLOCK_COMMENT = "/*"([^*]|\*+[^*/])*\*+"/"

// Espaços
WHITESPACE = [ \t\r\n\f]+

/* ========== REGRAS ========== */

%%

// Palavras-chave
"if"        { return new Symbol(sym.IF); }
"else"      { return new Symbol(sym.ELSE); }
"while"     { return new Symbol(sym.WHILE); }
"for"       { return new Symbol(sym.FOR); }
"int"       { return new Symbol(sym.INT); }
"float"     { return new Symbol(sym.FLOAT); }
"return"    { return new Symbol(sym.RETURN); }
"void"      { return new Symbol(sym.VOID); }

// Identificadores
{ID}        { return new Symbol(sym.ID, yytext()); }

// Constantes numéricas
{FLOAT}     { return new Symbol(sym.FLOAT_CONST, Double.parseDouble(yytext())); }
{INT}       { return new Symbol(sym.INT_CONST, Integer.parseInt(yytext())); }

// Operadores aritméticos
{PLUS}      { return new Symbol(sym.PLUS); }
{MINUS}     { return new Symbol(sym.MINUS); }
{TIMES}     { return new Symbol(sym.TIMES); }
{DIV}       { return new Symbol(sym.DIV); }

// Operadores relacionais
{EQ}        { return new Symbol(sym.EQ); }
{NEQ}       { return new Symbol(sym.NEQ); }
{LE}        { return new Symbol(sym.LE); }
{GE}        { return new Symbol(sym.GE); }
{LT}        { return new Symbol(sym.LT); }
{GT}        { return new Symbol(sym.GT); }

// Atribuição
{ASSIGN}    { return new Symbol(sym.ASSIGN); }

// Delimitadores
{SEMI}      { return new Symbol(sym.SEMI); }
{COMMA}     { return new Symbol(sym.COMMA); }
{LPAREN}    { return new Symbol(sym.LPAREN); }
{RPAREN}    { return new Symbol(sym.RPAREN); }
{LBRACE}    { return new Symbol(sym.LBRACE); }
{RBRACE}    { return new Symbol(sym.RBRACE); }
{LBRACKET}  { return new Symbol(sym.LBRACKET); }
{RBRACKET}  { return new Symbol(sym.RBRACKET); }

// Comentários
{LINE_COMMENT}    { /* ignora */ }
{BLOCK_COMMENT}   { /* ignora */ }

// Espaços em branco
{WHITESPACE}      { /* ignora */ }

// Qualquer coisa desconhecida
.           { System.err.println("Caractere inválido: " + yytext()); return new Symbol(sym.ERROR); }

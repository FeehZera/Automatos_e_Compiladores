import java_cup.runtime.Symbol;
%%

%class Lexer
%unicode
%line
%column
%cup

%eofval{
    return new Symbol(sym.EOF);
%eofval}

%%
\s+                             { /* ignora espaços em branco */ }
"//"[^\n]*                      { /* ignora comentários de linha */ }
"/*"([^*]|\*+[^*/])*\*+"/"      { /* ignora comentários de bloco */ }

// palavras-chave
"MAIUSCULA"                     { return new Symbol(sym.MAIUSCULA); }
"MINUSCULA"                     { return new Symbol(sym.MINUSCULA); }
"NUMERO"                        { return new Symbol(sym.NUMERO); }
"SIMBOLO"                       { return new Symbol(sym.SIMBOLO); }
"SENHA"                         { return new Symbol(sym.SENHA); }

// operadores / delimitadores
"+"                             { return new Symbol(sym.PLUS); }
";"                             { return new Symbol(sym.SEMICOLON); }
"->"                            { return new Symbol(sym.ARROW); }

// literais
[0-9]+                          { return new Symbol(sym.DIGIT, Integer.parseInt(yytext())); }
\"([^\"\\]|\\.)*\"              { return new Symbol(sym.STRING_LITERAL, yytext().substring(1, yytext().length()-1)); }
[a-zA-Z_][a-zA-Z0-9_]*          { return new Symbol(sym.IDENTIFIER, yytext()); }

// erro léxico
.                               { System.err.println("Erro Léxico: Caractere inválido '" + yytext() + "' na linha " + (yyline+1) + ", coluna " + (yycolumn+1)); }

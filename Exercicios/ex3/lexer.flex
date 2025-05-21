import java_cup.runtime.*;

%%
%class QueryLexer
%cup 
%unicode 
%line
%column 

%{
  private Symbol symbol(int type){
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value){
    return new Symbol(type, yyline, yycolumn, value);
  }

%}

letter = [a-zA-Z]
digit = [0-9]
id = {letter}({letter}|{digit})*
number = {digit}+
whitespace = [ \r\n\t]

%%
"FROM" {return symbol(sym.FROM);}
"SELECT" {return symbol(sym.SELECT);}
"WHERE" {return symbol(sym.WHERE);}
"AND" {return symbol(sym.AND);}
"," {return symbol(sym.COMMA);}
"=" {return symbol(sym.EQ);}
">" {return symbol(sym.GT);}
"<" {return symbol(sym.LT);}
">=" {return symbol(sym.GTEQ);}
"<=" {return symbol(sym.LTEQ);}
"!=" {return symbol(sym.NOTEQ);}
"*" {return symbol(sym.ALL);}

{id} {return symbol(sym.ID, yytext());}

{number} {return symbol(sym.NUMBER, Integer.valueOf(yytext()));}

{whitespace} { /* IGNORE */ }

\'([^\\']|\\.)*\' {return symbol(sym.STRING, yytext().substring(1, yytext().length() - 1));}

<<EOF>> { return symbol(sym.EOF);}
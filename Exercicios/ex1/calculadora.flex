import java_cup.runtime.*;

%%
%class Calc
%cup 
%line
%column

digit = [0-9]
number = {digit}+
whitespace = [ \n\r\t]

%{
  private Symbol symbol(int type){
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value){
    return new Symbol(type, yyline, yycolumn, value);
  }

%}

%%

"+" {return symbol(sym.PLUS);}
"-" {return symbol(sym.MINUS);}
"*" {return symbol(sym.TIMES);}
"/" {return symbol(sym.DIVIDE);}
"(" {return symbol(sym.LPAREN);}
")" {return symbol(sym.RPAREN);}
{number} {return symbol(sym.NUMBER, Integer.valueOf(yytext()));}
{whitespace} { /* Must be ignored */}
. {System.err.println("Invalid character: '" + yytext() + "'");}	   
<<EOF>> { return symbol(sym.EOF);}



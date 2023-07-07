/*
  Einfache Demonstration des Java-Lexers Flex.
*/

import java.io.*;

%%
%class Summe
%unicode
%type Double

%{
    double s = 0;

    public static void main(String args[]) throws IOException {
        Summe scanner = new Summe(new InputStreamReader(System.in));
        scanner.yylex();
        System.out.println("Summe = " + scanner.s);
    }

%}

%%

[+-]?[0-9]+("."[0-9]+)?  {
          System.out.println("Zahl " + yytext()); 
          s = s + Double.parseDouble(yytext());
        }

"/*"  ~"*/" { 
          /* Ignorieren */
	}

\r | \n | \r\n | [ \t\f] { 
          /* Ignorieren */
	}

/* Fehlerbehandlung */
. { 
  throw new RuntimeException("Unerlaubtes Zeichen \"" + yytext() + "\"."); 
  }

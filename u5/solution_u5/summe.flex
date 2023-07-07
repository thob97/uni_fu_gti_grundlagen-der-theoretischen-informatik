
/* import für das scanner Objekt */
import java.io.*;

/* %% Gibt an, dass es das Ende des User Codes ist und der Anfang der Optionen und Deklarationen */
%%

/* die Klasse wird Summe benannt, die Option unicode gewählt und der type Double deklariert */
%class Summe
%unicode
%type Double


%{
    /* double s zum Zählen der Summe wird deklariert */
    double s = 0;
    /* 4bii wird für die if else Abfrage verwendet */
    double produkt = 0;

    /* normale java main Funktion, welche eine Exception werfen kann */
    public static void main(String args[]) throws IOException {
        /* Ein scanner Objekt wird erstellt, welches fürs Lesen des IO-Streams benutzt wird */
        Summe scanner = new Summe(new InputStreamReader(System.in));
        /* Eingegebene String(Tokens) über den IO-Stream, werden an den Parser übergeben */
        scanner.yylex();
        /* Die Summe wird über den Zähler s ausgegeben */
        System.out.println("Summe = " + scanner.s);
    }

%}

/* Ende von Optionen und Deklarationen und Anfang von Lexikalische Regeln */
%%

/* Für alle Wörter die Doubles darstellen */
[+-]?[0-9]+("."[0-9]+)?  {
	  /* Die Eingegebene Zahl wird zusammen mit "Zahl" ausgegeben */
          System.out.println("Zahl " + yytext()); 
	  /* 4bii, wenn davor das "*" Symbol kam, wird Multipliziert */
	  if (produkt==1){
	      s = s * Double.parseDouble(yytext());
	      produkt = 0;
	  }
	  else{
	      /* der Eingegebene String wird zu einen doulbe umgewandelt und zu s addiert */
              s = s + Double.parseDouble(yytext());
	  }
        }

/* Wenn der unten gezeigt String (ohne Anführungszeuchen) eingegeben wird, passiert nichts. */
"/*"  ~"*/" { 
          /* Ignorieren */
	}

/* Wenn neue Zeilen (Enter),Leerzeichen und oder Zeilenumbruch eingegeben werden, passiert nichts */
\r | \n | \r\n | [ \t\f] { 
          /* Ignorieren */
	}

/*4bii) gibt das Ergebniss bei "=" Eingabe aus */
 = { 
          return s;
	}

/*4bii) lässt Kommentare im Stil von Haskell zu*/
 --(.*) { 
          /* Ignorieren */
	}

/*4bii) für die Produkt Abfrage*/
 "*" {
	produkt = 1;
	}

/* Für alle anderen Zeichen, die noch nicht abgefangen wurden, wird ein Fehler mit dem ersten falsche Zeichen ausgegeben */
. { 
  throw new RuntimeException("Unerlaubtes Zeichen " + yytext() + "\"."); 
  }

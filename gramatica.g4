grammar gramatica;

program
    : NL* cabecera NL
    (NL* declVariable)*
    NL* EOF;

cabecera: PROGRAMA CADENA;

declVariable: DATO ID_DATO COMO tipoDato;

tipoDato: real | entero | texto;
entero : NUMERO;
real : NUMERO CON DECIMALES;
texto: TEXTO;

CADENA :  ('"' (ESC_CHAR | ~["\\\n\r])* '"') | ('\'' (ESC_CHAR | ~['\\\n\r])* '\'');

// strings can be surronded by 'simple' or "double" commas
PROGRAMA: [Pp][Rr][Oo][Gg][Rr][Aa][Mm][Aa];
DATO: [dD][aA][tT][oO];
COMO: [Cc][Oo][Mm][Oo];
CON: [Cc][Oo][Nn];
DECIMALES: [Dd][Ee][Cc][Ii][Mm][Aa][Ll][Ee][Ss];
NUMERO: [Nn][UuÚú][Mm][Ee][Rr][Oo];
TEXTO: [Tt][Ee][Xx][Tt][Oo];

fragment ESC_CHAR :   '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;

ID_DATO: LETTER(DIGIT|LETTER)+;


fragment DIGIT : [0-9] ;
fragment LETTER : [a-zA-ZáéíóúïÁÉÍÓÚÏÑñ$_];


WS: [ \t\r]+ -> skip;
NL: [\n]+;



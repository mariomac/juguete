grammar gramatica;

NL: [\n]+;

start: header decl_variable*;

header: PROGRAMA WS {ignore=false} .~NL* {ignore=true} NL;

decl_variable: DATO WS LETTER(DIGIT|LETTER)+ WS COMO WS tipo_dato NL;

tipo_dato: NUMERO | TEXTO | (NUMERO CON_DECIMALES);

DIGIT : [0-9] ;
LETTER : [a-zA-ZáéíóúïÁÉÍÓÚÏÑñ$_];
WS: [ \t]+ ;
SK: [\r]+ -> skip;

// Keywords
COMO: [Cc][Oo][Mm][Oo];
DATO: [Dd][Aa][Tt][Oo];
PROGRAMA: [Pp][Rr][Oo][Gg][Rr][Aa][Mm][Aa];
NUMERO: [Nn][UuÚú][Mm][Ee][Rr][Oo];
TEXTO: [Tt][Ee][Xx][Tt][Oo];
CON_DECIMALES: [Cc][Oo][Nn] WS+ [Dd][Ee][Cc][Ii][Mm][Aa][Ll][Ee][Ss];




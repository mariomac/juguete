grammar Gramatica;

program
    : NL* header NL
    (NL* (varDeclaration | statement))*
    NL* EOF;

header: PROGRAMA STRING;

varDeclaration: DATO VAR_NAME COMO varType;

varType: number | text;
number : NUMERO;
text: TEXTO;

statement: assignment;

assignment: ltrAssign | rtlAssign;

ltrAssign: expr LTR VAR_NAME;
rtlAssign: VAR_NAME RTL expr;

expr: mulDiv ((ADD | SUB) mulDiv)*;
numberValue: intValue | realValue | stringValue;

mulDiv: term ((MUL | DIV) term)*;
term: numberValue | LPAR expr RPAR | VAR_NAME;

intValue: INT_NUMBER;
realValue: REAL_NUMBER;
stringValue: STRING;

STRING :  ('"' (ESC_CHAR | ~["\\\n\r])* '"') | ('\'' (ESC_CHAR | ~['\\\n\r])* '\'');

// strings can be surronded by 'simple' or "double" commas
PROGRAMA: [Pp][Rr][Oo][Gg][Rr][Aa][Mm][Aa];
DATO: [dD][aA][tT][oO];
COMO: [Cc][Oo][Mm][Oo];
NUMERO: [Nn][UuÚú][Mm][Ee][Rr][Oo];
TEXTO: [Tt][Ee][Xx][Tt][Oo];

// Operators
LTR: '->';
RTL: '<-';
EQ: '=';
GT: '>';
LT: '<';
GTE: '>=';
LTE: '<=';
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
POW: '^';

LPAR: '(';
RPAR: ')';

fragment ESC_CHAR :   '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;

VAR_NAME: LETTER(DIGIT|LETTER)+;
INT_NUMBER: DIGIT+;
REAL_NUMBER: DIGIT+ '.' DIGIT+;

fragment DIGIT : [0-9] ;
fragment LETTER : [a-zA-ZáéíóúïÁÉÍÓÚÏÑñ$_];

COMMENT: '//' ~[\n\r]* -> skip;
WS: [ \t\r]+ -> skip;
NL: [\n]+;



grammar Gramatica;

program
    : NL* header NL
    validProgramLine*
    NL* EOF;

header: PROGRAMA STRING;

validProgramLine: (NL* (varDeclaration | statement));

varDeclaration: DATO VAR_NAME COMO varType;

varType: number | text;
number : NUMERO;
text: TEXTO;

statement: assignment | ifElse;

assignment: ltrAssign | rtlAssign;

ltrAssign: expr LTR VAR_NAME;
rtlAssign: VAR_NAME RTL expr;

// Math expression
expr: mulDiv ((ADD | SUB) mulDiv)*;
numberValue: intValue | realValue | stringValue;

mulDiv: term ((MUL | DIV) term)*;
term: numberValue | LPAR expr RPAR | VAR_NAME;

intValue: INT_NUMBER;
realValue: REAL_NUMBER;
stringValue: STRING;



// Control statement: if-else
ifElse: SI logExpr LBRACE NL
    validProgramLine*
NL* RBRACE;


// Logical Expression
logExpr: andExpr (OR andExpr)*;
andExpr: logTerm (AND logTerm)*;
logTerm: compExpr | LPAR logExpr RPAR | NOT logExpr;
compExpr: expr (EQ|NEQ|GT|LT) expr;

STRING :  ('"' (ESC_CHAR | ~["\\\n\r])* '"') | ('\'' (ESC_CHAR | ~['\\\n\r])* '\'');

// strings can be surronded by 'simple' or "double" commas
PROGRAMA: [Pp][Rr][Oo][Gg][Rr][Aa][Mm][Aa];
DATO: [dD][aA][tT][oO];
COMO: [Cc][Oo][Mm][Oo];
NUMERO: [Nn][UuÚú][Mm][Ee][Rr][Oo];
TEXTO: [Tt][Ee][Xx][Tt][Oo];
SI: [Ss][Ii];

// Operators
LTR: '->';
RTL: '<-';
EQ: '=';
NEQ: '!=';
GT: '>';
LT: '<';
GTE: '>=';
LTE: '<=';
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
POW: '^';

// Logical operators
OR: [oOóÓ];
AND: [yY];
NOT: [Nn][Oo];

LPAR: '(';
RPAR: ')';
LBRACE: '{';
RBRACE: '}';

fragment ESC_CHAR :   '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;

VAR_NAME: LETTER(DIGIT|LETTER)+;
INT_NUMBER: ('+'|'-')? DIGIT+;
REAL_NUMBER: ('+'|'-')? DIGIT+ '.' DIGIT+;

fragment DIGIT : [0-9] ;
fragment LETTER : [a-zA-ZáéíóúïÁÉÍÓÚÏÑñ$_];

COMMENT: '//' ~[\n\r]* -> skip;
WS: [ \t\r]+ -> skip;
NL: [\n]+;



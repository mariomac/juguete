grammar Gramatica;

program
    : NL* header NL
    validProgramLine*
    NL* EOF;

header: PROGRAMA STRING;

validProgramLine: (NL* (varDeclaration | statement));

// Variable declaration
varDeclaration: DATO IDENTIFIER COMO varType;
varType: number | text | boolean;
number : NUMERO;
text: TEXTO;
boolean: LOGICO;

//////////////////////////
// Statements
//////////////////////////
statement: assignment | ifElse;

// Assignments
assignment: ltrAssign | rtlAssign;
ltrAssign: logExpr LTR IDENTIFIER;
rtlAssign: IDENTIFIER RTL logExpr;

// method invocation
//methodInvocation: IDENTIFIER IDENTIFIER ()*;

// Control statement: if-else
ifElse: SI logExpr LBRACE NL
    validProgramLine*
NL* RBRACE;

// Logical Expression
logExpr: andExpr (OR andExpr)*;
andExpr: logTerm (AND logTerm)*;
logTerm: compExpr | LPAR logExpr RPAR | NOT logExpr;
compExpr: expr (EQ|NEQ|GT|LT|GTE|LTE) expr;

// Math expression
expr: mulDiv ((ADD | SUB) mulDiv)*;
mulDiv: term ((MUL | DIV) term)*;
term: numberValue | booleanValue | LPAR expr RPAR | IDENTIFIER;

numberValue: intValue | realValue | stringValue;
intValue: INT_NUMBER;
realValue: REAL_NUMBER;
stringValue: STRING;
booleanValue: BOOLEAN;


STRING :  ('"' (ESC_CHAR | ~["\\\n\r])* '"') | ('\'' (ESC_CHAR | ~['\\\n\r])* '\'');

// strings can be surronded by 'simple' or "double" quotes
PROGRAMA: [Pp][Rr][Oo][Gg][Rr][Aa][Mm][Aa];
DATO: [dD][aA][tT][oO];
COMO: [Cc][Oo][Mm][Oo];
NUMERO: [Nn][UuÚú][Mm][Ee][Rr][Oo];
TEXTO: [Tt][Ee][Xx][Tt][Oo];
LOGICO: [Ll][OoÓó][Gg][Ii][Cc][Oo];
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

IDENTIFIER: LETTER(DIGIT|LETTER)+;
INT_NUMBER: ('+'|'-')? DIGIT+;
REAL_NUMBER: ('+'|'-')? DIGIT+ (','|'.') DIGIT+;
BOOLEAN: CIERTO | FALSO;

CIERTO: [Cc][Ii][Ee][Rr][Tt][Oo];
FALSO: [Ff][Aa][Ll][Ss][Oo];

fragment DIGIT : [0-9] ;
fragment LETTER : [a-zA-ZáéíóúïÁÉÍÓÚÏÑñ$_];

COMMENT: '//' ~[\n\r]* -> skip;
WS: [ \t\r]+ -> skip;
NL: [\n]+;



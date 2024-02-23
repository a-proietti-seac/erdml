lexer grammar ErdmlLexer;

options {
    caseInsensitive = true;
}

channels {
    ERDMLCOMMENT,
    ERRORCHANNEL
}

TABLE : 'TABLE';
REF : 'REF' ;

DOT                : '.';
LR_BRACKET         : '(';
RR_BRACKET         : ')';
LR_SBRACKET         : '[';
RR_SBRACKET         : ']';
LR_CBRACKET         : '{';
RR_CBRACKET         : '}';
COMMA              : ',';
SEMI               : ';';
AT_SIGN            : '@';
SINGLE_QUOTE_SYMB  : '\'';
DOUBLE_QUOTE_SYMB  : '"';
REVERSE_QUOTE_SYMB : '`';
COLON_SYMB         : ':';

STAR   : '*';
DIVIDE : '/';
MODULE : '%';
PLUS   : '+';
MINUS  : '-';

EQUAL_SYMBOL: '=';
GREATER_SYMBOL: '>';
LESS_SYMBOL: '<';
EXCLAMATION_SYMBOL: '!';

OTM: LESS_SYMBOL;
MTO: GREATER_SYMBOL;
OTO: MINUS ;
MTM: LESS_SYMBOL GREATER_SYMBOL;

ML_COMMENT: '/*' .*? '*/';
SL_COMMENT: (('//' [ \t]* | '#') ~[\r\n]* ('\r'? '\n' | EOF) | '//' ('\r'? '\n' | EOF));

SPACE : [ \t\r\n]+     -> channel(HIDDEN);
SPEC_ERDML_COMMENT : '/*!' .+? '*/' -> channel(ERDMLCOMMENT);
COMMENT_INPUT : ML_COMMENT -> channel(HIDDEN);
LINE_COMMENT : SL_COMMENT -> channel(HIDDEN);

UNQUOTED: UNQUOTED_LITERAL;
fragment UNQUOTED_LITERAL : [A-Z_$0-9\u0080-\uFFFF]*? [A-Z_$\u0080-\uFFFF]+? [A-Z_$0-9\u0080-\uFFFF]*;

STRING_LITERAL: DQUOTA_STRING | SQUOTA_STRING | BQUOTA_STRING;
fragment DQUOTA_STRING     : '"' ( '\\' . | '""' | ~('"' | '\\'))* '"';
fragment SQUOTA_STRING     : '\'' ('\\' . | '\'\'' | ~('\'' | '\\'))* '\'';
fragment BQUOTA_STRING     : '`' ( ~'`' | '``')* '`';

DECIMAL_LITERAL : DEC_DIGIT+;
FLOAT_LITERAL : (DEC_DIGIT+)? DOT DEC_DIGIT+;
EXPONENT_NUM_LITERAL : EXPONENT_NUM_PART;
fragment EXPONENT_NUM_PART : DEC_DIGIT+ 'E' [-+]? DEC_DIGIT+;
fragment HEX_DIGIT : [0-9A-F];
fragment DEC_DIGIT : [0-9];

// fragment BIT_STRING_L      : 'B' '\'' [01]+ '\'';
// fragment IP_ADDRESS        : [0-9]+ '.' [0-9.]+ | [0-9A-F]* ':' [0-9A-F]* ':' [0-9A-F:]+;

// Last tokens must generate Errors
ERROR_RECONGNIGION: . -> channel(ERRORCHANNEL);
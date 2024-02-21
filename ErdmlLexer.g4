lexer grammar ErdmlLexer;

options {
    caseInsensitive = true;
}

RelationType: OTM | MTO | OTO | MTM;
OTM: '<';
MTO: '>';
OTO: '-';
MTM: '<>';

ColumnAttribute:
    PRIMARY_KEY |
    NOT_NULL |
    UNIQUE |
    C_NOTES
    ;
    
PRIMARY_KEY: 'PRIMARY KEY' | 'PK';
NOT_NULL: 'NOT NULL';
UNIQUE: 'UNIQUE';

C_NOTES: NOTE COLON (' ')? '"' ~'"'* '"';

TableAttribute: NOTE;
NOTE: 'NOTE';

TABLE: 'TABLE';
REF: 'REF';

LCURL: '{';
RCURL: '}';

LSQUA: '[';
RSQUA: ']';

LBRAC: '(';
RBRAC: ')';

COLON: ':';
SEMI: ';';

COMMA: ',';
DOT: '.';

NUMBER: [\-0-9]+;

STRING:
    ('"')?[a-z_]+[a-z0-9_]*('"')? |
    '"' ~'"'* '"'
    ;

WS     : [ \t\r\n]+ -> skip ;
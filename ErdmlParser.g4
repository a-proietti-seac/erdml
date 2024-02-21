parser grammar ErdmlParser;

options {
    tokenVocab = ErdmlLexer;
}

parse: statement? (statement)*;

statement: table | ref;

catalogName: STRING;
schemaName: STRING;

table:
    TABLE
    (catalogName DOT)?
    (schemaName DOT)?
    tableName
    (LSQUA tableAttributes RSQUA)?
    LCURL
    columns
    RCURL;
    
tableAttribute:
    attributeType
    COLON
    attributeValue
    ;
    
attributeType:
    TableAttribute
    ;

attributeValue:
    STRING
    ;

tableAttributes:
    tableAttribute?
    (COMMA tableAttribute)*
    ;
    
tableName: STRING;
columns: column? (COMMA column)*?;

column:
    columnName
    columnType
    (LSQUA columnAttributes RSQUA)?
    ;
    
columnName:
    STRING
    ;
    
columnType:
    columnTypeName
    (LBRAC columnTypeAttribute RBRAC)?
    ;
    
columnTypeName:
    STRING
    ;
    
columnTypeAttribute:
    (
        STRING |
        NUMBER
        (COMMA NUMBER)?
    )
    ;
    
columnAttributes:
    ColumnAttribute?
    (COMMA ColumnAttribute)*
    ;

ref:
    REF
    refName?
    COLON
    refFrom
    refRelation
    refTo
    ;
    
refName:
    STRING
    ;
    
refRelation:
    RelationType
    ;
    
refFrom:
    (catalogName DOT)?
    (schemaName DOT)?
    tableName
    DOT
    columnName
    ;
    
refTo:
    (catalogName DOT)?
    (schemaName DOT)?
    tableName
    DOT
    columnName
    ;
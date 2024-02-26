parser grammar ErdmlParser;

options {
    tokenVocab = ErdmlLexer;
}

root : erdmlStatements? (DIVIDE DIVIDE)? EOF;

erdmlStatements
    : (erdmlStatement SEMI? | emptyStatement_)* (
        erdmlStatement (SEMI)?
        | emptyStatement_
    )
    ;

erdmlStatement
    : tableStatement | refStatement
    ;

emptyStatement_
    : SEMI
    ;
    
// table
tableStatement
    : TABLE tableName (tableNote)? LR_CBRACKET
        columnStatement (COMMA columnStatement)*
    RR_CBRACKET
    ;

tableName : tableCatalogId;
tableNote : multiLineComment;

columnStatement : columnName columnType (columnComment)?;
columnComment : multiLineComment;
columnName : istring;

columnType
    : istring (LR_BRACKET columnTypeAttribute RR_BRACKET)?
    ;

columnTypeAttribute
    : number (COMMA number)*
    ;

// ref    
refStatement
    : REF (refName)? COLON_SYMB
        refFrom
        refType
        refTo
        (refComment)?
    ;
    
refName : istring;
refFrom : refCatalogId;
refTo : refCatalogId;

refType
    : oneToMany 
    | manyToOne 
    | oneToOne 
    | manyToMany
    ;

refComment
    : multiLineComment
    | singleLineComment
    ;

// helper types

oneToMany : OTM;
manyToOne : MTO;
oneToOne : OTO;
manyToMany : MTM;

singleLineComment : SL_COMMENT;
multiLineComment : ML_COMMENT;

unquoted : UNQUOTED;
quoted: STRING_LITERAL;
istring: unquoted | quoted;
istringList : LR_SBRACKET unquoted (COMMA istring)* RR_SBRACKET;

tableCatalogId : (istring '.')? tableSchemaId ;
tableSchemaId : (istring '.')? tableTableId ;
tableTableId
    : istring
    ;

refCatalogId : (istring '.')? refSchemaId;
refSchemaId : (istring '.')? refTableId;
refTableId : istring '.' refColumnId;
refColumnId
    : istringList
    | istring
    ;

decimal : DECIMAL_LITERAL;
float : FLOAT_LITERAL;
exponent : EXPONENT_NUM_LITERAL;
number
    : float 
    | exponent
    | decimal
    ;

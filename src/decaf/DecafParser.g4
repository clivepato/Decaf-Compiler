/*
 * A VERY minimal skeleton for your parser, provided by Emma Norling.
 *
 * Your parser should use the tokens provided by your lexer in rules.
 * Even if your lexer appeared to be working perfectly for stage 1,
 * you might need to adjust some of those rules when you implement
 * your parser.
 *
 * Remember to provide documentation too (including replacing this
 * documentation).
 *
 */
parser grammar DecafParser;
options { tokenVocab = DecafLexer; }

// This rule says that a program consists of the tokens CLASS ID LCURLY RCURLY EOF nothing more nothing less,
// in exactly that order. However obviously something (quite a lot of something) needs to go between the curly
// brackets. You need to write the rules (based on the provided grammar) to capture this.
program : CLASS ID LCURLY field_decl* method_decl* RCURLY EOF;

field_name : ID | (ID LEFTSQUAREBRACKET NUMBER RIGHTSQUAREBRACKET);

field_decl : type field_name (COMMA field_name)* SEMI;

method_decl : (type | VOID) ID LEFTBRACKET (type ID (COMMA type ID)*)? RIGHTBRACKET block;

block : LCURLY var_decl* statement* RCURLY;

var_decl : type var_name (COMMA var_name)*SEMI;
var_name: ID;

type : INT | BOOLEAN ;

statement : location assign_op expr SEMI # Assign
| method_call SEMI # MC
| IF LEFTBRACKET expr RIGHTBRACKET block (ELSE block)? # If
| FOR ID EQUALS expr COMMA expr block # For
| RETURN expr? SEMI # Return
| BREAK SEMI # Break
| CONTINUE SEMI # Continue
| block # Bl ;

assign_op : EQUALS
| ADDITIONASSIGNMENT
| SUBTRACTIONASSIGNMENT ;

method_call : method_name  (expr (COMMA expr)*)?
|CALLOUT STRING LEFTBRACKET (COMMA callout_arg (COMMA callout_arg)*)? RIGHTBRACKET;

method_name : ID;

location : ID |ID LEFTSQUAREBRACKET expr RIGHTSQUAREBRACKET;

//screecast 4 week 4

expr : SUBTRACT expr
| LOGICALNOT expr
| expr (MULTIPLY|DIVIDE|MODULUS) expr
| expr (ADD | SUBTRACT) expr
| expr (rel_op) expr 
| expr (eq_op) expr
| expr (AND) expr 
| expr (OR) expr 
| (location)
| (method_call) 
| (literal) 
| LEFTBRACKET expr RIGHTBRACKET;

callout_arg : expr | STRING;

bin_op : arith_op | rel_op | eq_op | cond_op ;

arith_op : ADD | SUBTRACT | MULTIPLY | DIVIDE | MODULUS ;

rel_op : LESSTHAN | GREATERTHAN | LESSTHANOREQUAL | GREATERTHANOREQUAL ;

eq_op : EQUALTO | NOTEQUALTO ;

cond_op : AND | OR ;

bool_literal: TRUE | FALSE;

literal : INT | CHAR | bool_literal; 
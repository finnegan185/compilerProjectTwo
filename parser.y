/* Compiler Theory and Design
   Code edited by Zack Finnegan
   From code written by
   Dr. Duane J. Jarc */

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%error-verbose

%token IDENTIFIER
%token INT_LITERAL 
%token REAL_LITERAL
%token BOOL_LITERAL

%token ADDOP MULOP RELOP ANDOP OROP NOTOP REMOP EXPOP ARROW REAL

%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS
%token CASE ELSE ENDCASE ENDIF IF OTHERS THEN WHEN

%%

function:	
	function_header optional_variable body ;
	
function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' |
	error ';' ;

optional_variable:
	optional_variable variable | error ';' | ;

variable:
	IDENTIFIER ':' type IS statement_ ;

parameters:
	parameters ',' parameter | parameter | ;

parameter:
	IDENTIFIER ':' type;

type:
	INTEGER |
	REAL |
	BOOLEAN ;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' ;
	
statement:
	expression |
	REDUCE binary_operator reductions ENDREDUCE |
	IF expression THEN statement_ ELSE statement_ ENDIF |
    CASE expression IS cases OTHERS ARROW statement_ ENDCASE ;

cases: 
	cases case | ;

case:
	WHEN INT_LITERAL ARROW statement ';' |
	error ';' ;

reductions:
	reductions statement_ |
	;
		    
expression:
	expression OROP binary_logic |
	binary_logic ;

binary_logic:
	binary_logic ANDOP unary_logic |
	unary_logic ;
	
unary_logic:
	NOTOP unary_logic |
	relation ;

binary_operator: ADDOP | MULOP | REMOP | EXPOP | RELOP | ANDOP | OROP ;

relation:
	relation RELOP term |
	term;

term:
	term ADDOP factor |
	factor ;
      
factor:
	factor MULOP exp |
	factor REMOP exp |
	exp ;

exp:
	primary |
	primary EXPOP exp ;

primary:
	'(' expression ')' |
	INT_LITERAL | REAL_LITERAL | BOOL_LITERAL |
	IDENTIFIER ;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 

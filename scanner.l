/* Compiler Theory and Design
   Code edited by Zack Finnegan 
   from code created by Dr. Duane J. Jarc
   Date: 7.9.2020 */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws			[ \t\r]+
comment	\-\-.*\n|\/\/.*\n
line		[\n]
id			[A-Za-z][A-Za-z0-9]*(\_?[A-Za-z0-9]+)*
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
real_lit	{int}+(\.?{int}*)?([eE][+|-]?{int}+)?
%%

{ws}		   { ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"<"			{ ECHO; return(RELOP); }
"="			{ ECHO; return(RELOP); }
"/="	   	{ ECHO; return(RELOP); }
">"			{ ECHO; return(RELOP); }
">="		   { ECHO; return(RELOP); }
"<="	   	{ ECHO; return(RELOP); }
"=>"	   	{ ECHO; return(ARROW); }
"+"			{ ECHO; return(ADDOP); }
"-"			{ ECHO; return(ADDOP); }
"*"			{ ECHO; return(MULOP); }
"/"			{ ECHO; return(MULOP); }
rem			{ ECHO; return(REMOP); }
"**"		   { ECHO; return(EXPOP); }
begin		   { ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end			{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	   { ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		   	{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
case		   { ECHO; return(CASE); }
else		   { ECHO; return(ELSE); }
endcase		{ ECHO; return(ENDCASE); }
true		   { ECHO; return(BOOL_LITERAL); }
false		   { ECHO; return(BOOL_LITERAL); }
endif		   { ECHO; return(ENDIF); }
if			   { ECHO; return(IF); }
others		{ ECHO; return(OTHERS); }
real		   { ECHO; return(REAL); }
then		   { ECHO; return(THEN); }
when		   { ECHO; return(WHEN); }
and			{ ECHO; return(ANDOP); }
or			   { ECHO; return(OROP); }
not			{ ECHO; return(NOTOP); }
{id}	   	{ ECHO; return(IDENTIFIER);}
{int}		   { ECHO; return(INT_LITERAL); }
{real_lit}	{ ECHO; return(REAL_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.			   { ECHO; appendError(LEXICAL, yytext); }

%%

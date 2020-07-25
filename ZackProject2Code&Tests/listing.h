// CMSC 430
// Code used and unedited by Zack Finnegan
// Written by Dr. Duane J. Jarc

// This file contains the function prototypes for the functions that produce the // compilation listing

enum ErrorCategories
{
	LEXICAL,
	SYNTAX,
	GENERAL_SEMANTIC,
	DUPLICATE_IDENTIFIER,
	UNDECLARED
};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

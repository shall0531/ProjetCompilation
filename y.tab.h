/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IF = 258,
     ELSE = 259,
     WHILE = 260,
     PRINTF = 261,
     GT = 262,
     LT = 263,
     GEQ = 264,
     LEQ = 265,
     NEQ = 266,
     EQ = 267,
     OR = 268,
     AND = 269,
     NOT = 270,
     ASSIGN = 271,
     INT = 272,
     NUMBER = 273,
     ID = 274,
     LOWER_THAN_ELSE = 275
   };
#endif
/* Tokens.  */
#define IF 258
#define ELSE 259
#define WHILE 260
#define PRINTF 261
#define GT 262
#define LT 263
#define GEQ 264
#define LEQ 265
#define NEQ 266
#define EQ 267
#define OR 268
#define AND 269
#define NOT 270
#define ASSIGN 271
#define INT 272
#define NUMBER 273
#define ID 274
#define LOWER_THAN_ELSE 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 18 "StenC.y"
{
    int valeur;
  char* string;
  char relation;
  struct symbol* quad;

  struct {
	struct symbol* result;
        struct quad* code;
    }codegen;

  struct {
    struct symbol* quad;
    struct quad* code;
    struct quad_list* next;
  } codegoto;
 
 struct {
    struct quad* code;
    struct quad_list* next;
  } codestmt;
 
 struct {
    struct quad* code;
    struct quad_list* true;
    struct quad_list* false;
  } codeexpr;
}
/* Line 1529 of yacc.c.  */
#line 118 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;


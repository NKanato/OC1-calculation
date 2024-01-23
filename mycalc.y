%{
#include <stdio.h>
#include <stdlib.h>

// yacc が定義する内部関数のプロトタイプ宣言
#define YYDEBUG 1
extern  int  yydebug ;
extern  int  yyerror( char const* ) ;
extern  char *yytext ;
extern  FILE *yyin ;

// 最初に呼び出される関数yyparse()
extern  int  yyparse( void ) ;

// 字句解析を呼び出す関数yylex()
extern  int  yylex( void ) ;
%}

// 字句(トークン)の定義
%union {
   int  int_value;
}
%token <int_value>  INT_LITERAL
%token ADD SUB MUL DIV CR  //今回の課題で直さないといけないところ24.1.23
%type  <int_value>   expression term primary_expression

%%
// 構文の定義
line_list  : line                // 行の繰り返し
           | line_list line
           ;

line       : expression CR       { printf( ">>%d\n" , $1 ) ; }//expressionの後ろにCRが来ると、それを式として扱うと定義する
           ;

// 以下のBNFルールは、単純に再帰に置き換えると
//   無限に再帰して異常終了するものであることに注意
expression : term
           | expression ADD term { $$ = $1 + $3 ; }
           | expression SUB term { $$ = $1 - $3 ; }
           ;

term       : primary_expression
           | term MUL primary_expression { $$ = $1 * $3 ; }
           | term DIV primary_expression { $$ = $1 / $3 ; }
           ;

//因子(primary_expression)は整数値(INT_LITERAL)となる
primary_expression
           : INT_LITERAL
           ;
%%

// 補助関数の定義
int yyerror( char const* str )
{
   fprintf( stderr , "parser error near %s\n" , yytext ) ;
   return 0 ;
}

int main( void )
{
   yydebug = 0 ;        // yydebug=1 でデバッグ情報表示
   yyin = stdin ;
   if ( yyparse() ) {   // 構文解析を開始
      fprintf( stderr , "Error ! Error ! Error !\n" ) ;
      return ( 1 ) ;
   }
   return ( 0 ) ;
}

%{
#include <stdio.h>
// yaccが出力するヘッダファイル
#include "mycalc.tab.h"

int yywrap( void )
{
   // 1: スキャナ終了
   // 0: yyin を切り替えて継続
   return 1 ;
}
%}
%%
"+"  return ADD ;/*トークンを返す*/
"-"  return SUB ;
"*"  return MUL ;
"/"  return DIV ;
"%"  return MOD ;/*あまり*/
"^"  return POW ;/*べき乗*/
"("  return LP ;
")"  return RP ;
"\n" return CR  ;
[0-9][0-9]* {
   // 入力はyytextに格納されている。
   int temp ;
   sscanf( yytext , "%d" , &temp ) ;
   yylval.int_value = temp ;
   // 返り値は、字句(トークン)の種別を表す定数
   return INT_LITERAL;
}
%%

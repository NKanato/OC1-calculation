%{
#include <stdio.h>
// yacc���o�͂���w�b�_�t�@�C��
#include "mycalc.tab.h"

int yywrap( void )
{
   // 1: �X�L���i�I��
   // 0: yyin ��؂�ւ��Čp��
   return 1 ;
}
%}
%%
"+"  return ADD ;/*�g�[�N����Ԃ�*/
"-"  return SUB ;
"*"  return MUL ;
"/"  return DIV ;
"\n" return CR  ;
[0-9][0-9]* {
   // ���͂�yytext�Ɋi�[����Ă���B
   int temp ;
   sscanf( yytext , "%d" , &temp ) ;
   yylval.int_value = temp ;
   // �Ԃ�l�́A����(�g�[�N��)�̎�ʂ�\���萔
   return INT_LITERAL;
}
%%
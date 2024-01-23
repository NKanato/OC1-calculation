%{
#include <stdio.h>
#include <stdlib.h>

// yacc ����`��������֐��̃v���g�^�C�v�錾
#define YYDEBUG 1
extern  int  yydebug ;
extern  int  yyerror( char const* ) ;
extern  char *yytext ;
extern  FILE *yyin ;

// �ŏ��ɌĂяo�����֐�yyparse()
extern  int  yyparse( void ) ;

// �����͂��Ăяo���֐�yylex()
extern  int  yylex( void ) ;
%}

// ����(�g�[�N��)�̒�`
%union {
   int  int_value;
}
%token <int_value>  INT_LITERAL
%token ADD SUB MUL DIV CR  //����̉ۑ�Œ����Ȃ��Ƃ����Ȃ��Ƃ���24.1.23
%type  <int_value>   expression term primary_expression

%%
// �\���̒�`
line_list  : line                // �s�̌J��Ԃ�
           | line_list line
           ;

line       : expression CR       { printf( ">>%d\n" , $1 ) ; }//expression�̌���CR������ƁA��������Ƃ��Ĉ����ƒ�`����
           ;

// �ȉ���BNF���[���́A�P���ɍċA�ɒu���������
//   �����ɍċA���Ĉُ�I��������̂ł��邱�Ƃɒ���
expression : term
           | expression ADD term { $$ = $1 + $3 ; }
           | expression SUB term { $$ = $1 - $3 ; }
           ;

term       : primary_expression
           | term MUL primary_expression { $$ = $1 * $3 ; }
           | term DIV primary_expression { $$ = $1 / $3 ; }
           ;

//���q(primary_expression)�͐����l(INT_LITERAL)�ƂȂ�
primary_expression
           : INT_LITERAL
           ;
%%

// �⏕�֐��̒�`
int yyerror( char const* str )
{
   fprintf( stderr , "parser error near %s\n" , yytext ) ;
   return 0 ;
}

int main( void )
{
   yydebug = 0 ;        // yydebug=1 �Ńf�o�b�O���\��
   yyin = stdin ;
   if ( yyparse() ) {   // �\����͂��J�n
      fprintf( stderr , "Error ! Error ! Error !\n" ) ;
      return ( 1 ) ;
   }
   return ( 0 ) ;
}

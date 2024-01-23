flex mycalc.l
bison -d mycalc.y
bcc32 mycalc.tab.c lex.yy.c
mycalc.tab

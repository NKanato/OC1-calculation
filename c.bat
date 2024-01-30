@set PATH=c:\oci-tools\bcc55\bin;c:\oci-tools\GnuWin32\bin;%PATH%
flex mycalc.l
bison -d mycalc.y
bcc32 mycalc.tab.c lex.yy.c
mycalc.tab

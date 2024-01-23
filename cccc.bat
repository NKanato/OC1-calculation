if %1==a(
    echo yeah
    flex mycalc.l
) else (
    if %1==2(
    bison -d mycalc.y
    ) else (
        if %1 == 3(
        bcc32 mycalc.tab.c lex.yy.c
        ) else (
            flex mycalc.l
            bison -d mycalc.y
            bcc32 mycalc.tab.c lex.yy.c
        )
    )
)

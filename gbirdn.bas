SCREEN 13

ballx = 15
bally = 10
ballr = 10
wingup = 1

CIRCLE (ballx, bally), ballr
CIRCLE (ballx - 4, bally), 2
CIRCLE (ballx + 4, bally), 2
IF wingup = 1 THEN
    LINE (ballx + ballr, bally)-(ballx + ballr + 4, bally - 4)
    LINE (ballx - ballr, bally)-(ballx - ballr - 4, bally - 4)
ELSE
    LINE (ballx + ballr, bally)-(ballx + ballr + 4, bally + 4)
    LINE (ballx - ballr, bally)-(ballx - ballr - 4, bally + 4)
END IF

gbirdup = _NEWIMAGE(30, 20, 13)
_PUTIMAGE (1, 1)-(30, 20), , gbirdup, (1, 1)-(30, 20)
CLS

ballx = 15
bally = 10
ballr = 10
wingup = 0

CIRCLE (ballx, bally), ballr
CIRCLE (ballx - 4, bally), 2
CIRCLE (ballx + 4, bally), 2
IF wingup = 1 THEN
    LINE (ballx + ballr, bally)-(ballx + ballr + 4, bally - 4)
    LINE (ballx - ballr, bally)-(ballx - ballr - 4, bally - 4)
ELSE
    LINE (ballx + ballr, bally)-(ballx + ballr + 4, bally + 4)
    LINE (ballx - ballr, bally)-(ballx - ballr - 4, bally + 4)
END IF

gbirddown = _NEWIMAGE(30, 20, 13)
_PUTIMAGE (1, 1)-(30, 20), , gbirddown, (1, 1)-(30, 20)
CLS

DATA 000,000,000,000,000,000,000,000,000,000
DATA 000,000,000,006,006,006,000,000,000,000
DATA 000,000,006,006,006,006,006,000,000,000
DATA 000,006,012,006,006,006,006,006,000,000
DATA 000,006,006,006,006,012,006,006,000,000
DATA 000,006,006,006,006,006,006,006,000,000
DATA 000,000,006,006,012,006,006,000,000,000
DATA 000,000,006,006,006,006,000,000,000,000
DATA 000,000,000,006,006,000,000,000,000,000
DATA 000,000,000,000,000,000,000,000,000,000

FOR y = 1 TO 10
    FOR x = 1 TO 10

        READ c
        PSET (x, y), c
    NEXT
NEXT

obstacle = _NEWIMAGE(11, 11, 13)
_PUTIMAGE (1, 1)-(10, 10), , obstacle, (1, 1)-(10, 10)
CLS

DATA 000,000,000,000,000,000,000,000,000,000
DATA 000,000,004,004,000,004,004,000,000,000
DATA 000,004,012,012,004,012,012,004,000,000
DATA 000,004,012,012,012,012,012,004,000,000
DATA 000,004,012,012,012,012,012,004,000,000
DATA 000,004,012,012,012,012,012,004,000,000
DATA 000,000,004,012,012,012,004,000,000,000
DATA 000,000,000,004,012,004,000,000,000,000
DATA 000,000,000,000,004,000,000,000,000,000
DATA 000,000,000,000,000,000,000,000,000,000

FOR y = 1 TO 10
    FOR x = 1 TO 10

        READ c
        PSET (x, y), c
    NEXT
NEXT

food = _NEWIMAGE(11, 11, 13)
_PUTIMAGE (1, 1)-(10, 10), , food, (1, 1)-(10, 10)
CLS

Start:
gbx = 30
gby = 16
gbp = 1
glife = 10

DIM ox(100), oy(100), osp(100)
numo = 5

FOR i = 1 TO 100
    ox(i) = 500
    oy(i) = 10 + (RND * 180)
    osp(i) = 1 + (RND * 2)
NEXT

DIM SHARED fx, fy, score
score = 0
CALL ResetFood

DO
    _LIMIT 60
    CLS

    IF gbp = 1 THEN
        _PUTIMAGE (gbx, gby), gbirdup
        gbp = 0
    ELSE
        _PUTIMAGE (gbx, gby), gbirddown
        gbp = 1
    END IF

    _PUTIMAGE (fx, fy), food

    FOR i = 1 TO numo
        _PUTIMAGE (ox(i), oy(i)), obstacle
    NEXT

    IF _KEYDOWN(CVI(CHR$(0) + "H")) THEN gby = gby - 1
    IF _KEYDOWN(CVI(CHR$(0) + "P")) THEN gby = gby + 1
    IF _KEYDOWN(CVI(CHR$(0) + "K")) THEN gbx = gbx - 1
    IF _KEYDOWN(CVI(CHR$(0) + "M")) THEN gbx = gbx + 1
    IF _KEYDOWN(27) THEN END

    IF gbx + 30 > 319 THEN gbx = 319 - 30
    IF gbx < 0 THEN gbx = 0
    IF gby + 20 > 199 THEN gby = 199 - 20
    IF gby < 10 THEN gby = 10

    fx = fx - 1

    IF fx < 10 THEN CALL ResetFood
    IF (fx >= gbx) AND (fx <= gbx + 30) AND (fy >= gby) AND (fy <= gby + 20) THEN CALL AddScoreAndResetFood

    FOR i = 1 TO numo
        IF (ox(i) >= gbx) AND (ox(i) <= gbx + 30) THEN
            IF (oy(i) >= gby) AND (oy(i) <= gby + 20) THEN
                glife = glife - 1
                ox(i) = 20
            END IF
        END IF

        ox(i) = ox(i) - osp(i)

        IF ox(i) < 30 THEN
            ox(i) = 500
            oy(i) = 10 + (RND * 180)
            osp(i) = 1 * (RND * 2)
        END IF
    NEXT

    LOCATE 1, 1: PRINT "Score"; score; " Life"; glife

    IF (score >= 10) AND ((score MOD 10) = 0) THEN
        score = score + 1
        numo = numo + 5
        IF numo > 100 THEN numo = 40
    END IF


    IF (glife < 3) THEN
        IF score >= 30 THEN
            glife = glife + 5
            score = score - 30
        END IF
    END IF

    IF glife < 0 THEN
        CLS
        LOCATE 10, 10: PRINT "GAME OVER!!"
        _DISPLAY
        _DELAY 2
        GOTO Start
    END IF

    _DISPLAY
LOOP


SUB ResetFood
    fx = 330
    fy = 10 + (RND * 100)
END SUB

SUB AddScoreAndResetFood
    score = score + 1
    CALL ResetFood
END SUB


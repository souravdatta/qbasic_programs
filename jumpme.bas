SCREEN 13
_FULLSCREEN

DIM player1, player2, tree1, lifei
DIM playerx, playery, state, jumped
DIM trees(100)
DIM medx


DATA 000,000,000,000,006,006,000,000,000,000
DATA 000,000,000,006,005,005,000,000,000,000
DATA 000,000,006,005,005,005,006,000,000,000
DATA 004,004,006,005,005,005,006,004,004,000
DATA 000,000,006,005,005,005,006,000,000,000
DATA 000,000,000,006,005,006,000,000,000,000
DATA 000,000,000,006,000,006,000,000,000,000
DATA 000,000,000,006,000,006,000,000,000,000
DATA 000,000,006,000,000,000,006,000,000,000
DATA 008,006,008,000,000,000,008,006,008,000

FOR y = 1 TO 10
    FOR x = 1 TO 10

        READ c
        PSET (x, y), c
    NEXT
NEXT

player1 = _NEWIMAGE(11, 11, 13)
_PUTIMAGE (1, 1)-(10, 10), , player1, (1, 1)-(10, 10)
CLS

DATA 000,000,000,000,006,006,000,000,000,000
DATA 000,000,000,006,005,005,000,000,000,000
DATA 000,000,006,005,005,005,006,000,000,000
DATA 004,004,006,005,005,005,006,004,004,000
DATA 000,000,006,005,005,005,006,000,000,000
DATA 000,000,000,006,005,006,000,000,000,000
DATA 000,000,000,006,000,006,000,000,000,000
DATA 000,000,000,006,000,006,000,000,000,000
DATA 000,000,006,000,000,000,006,000,000,000
DATA 000,008,006,008,000,008,006,008,000,000

FOR y = 1 TO 10
    FOR x = 1 TO 10

        READ c
        PSET (x, y), c
    NEXT
NEXT

player2 = _NEWIMAGE(11, 11, 13)
_PUTIMAGE (1, 1)-(10, 10), , player2, (1, 1)-(10, 10)
CLS

DATA 000,002,002,002,000,000,000,000,000,000
DATA 000,002,010,002,000,000,000,000,000,000
DATA 000,002,010,002,000,000,002,002,002,000
DATA 000,002,010,002,000,000,002,010,002,000
DATA 000,002,002,002,002,002,002,010,002,000
DATA 000,002,010,010,010,010,010,010,002,000
DATA 000,002,010,002,002,002,002,002,002,000
DATA 000,002,010,002,000,000,000,000,000,000
DATA 000,002,010,002,000,000,000,000,000,000
DATA 000,002,002,002,000,000,000,000,000,000

FOR y = 1 TO 10
    FOR x = 1 TO 10

        READ c
        PSET (x, y), c
    NEXT
NEXT

tree1 = _NEWIMAGE(11, 11, 13)
_PUTIMAGE (1, 1)-(10, 10), , tree1, (1, 1)-(10, 10)
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

lifei = _NEWIMAGE(11, 11, 13)
_PUTIMAGE (1, 1)-(10, 10), , lifei, (1, 1)-(10, 10)
CLS


RestartGame:
playerx = 90
playery = 140
jumped = 0
state = 1
numtrees = 10
life = 100
medx = 400 + (RND * 100)

FOR i = 0 TO 100
    trees(i) = 330 + (RND * 600) + 60 + (RND * 20)
NEXT

DO
    _LIMIT 60
    CLS

    LINE (0, 152)-(320, 152)

    IF state = 1 THEN
        _PUTIMAGE (playerx, playery), player1
        state = 2
    ELSE
        _PUTIMAGE (playerx, playery), player2
        state = 1
    END IF

    FOR i = 0 TO numtrees
        IF (trees(i) + 5 >= playerx) AND (trees(i) + 5 <= playerx + 10) THEN
            IF (playery + 10 <= 150) AND (playery + 10 >= 140) THEN
                life = life - 1
            END IF
        END IF

        IF (trees(i) >= 0) AND (trees(i) <= 320) THEN
            _PUTIMAGE (trees(i), 140), tree1
        ELSE
            IF trees(i) <= 20 THEN
                trees(i) = 330 + (RND * 600) + 60 + (RND * 20)
            END IF
        END IF

        trees(i) = trees(i) - 1
    NEXT

    IF (medx >= 0) AND (medx <= 320) THEN
        _PUTIMAGE (medx, 60), lifei
    END IF

    IF (medx >= playerx) AND (medx <= playerx + 10) AND (playery + 10 >= 60) AND (playery <= 60) THEN
        life = life + 10
        medx = -30
    END IF

    IF medx <= 20 THEN
        medx = 400 + (RND * 100)
    END IF

    medx = medx - 1

    IF _KEYDOWN(CVI(CHR$(0) + "H")) THEN
        playery = playery - 5
        jumped = 11
    END IF

    IF jumped > 0 THEN
        jumped = jumped - 1
    ELSE
        jumped = 0
        playery = 140
    END IF

    IF _KEYDOWN(27) THEN END

    LOCATE 1, 1: PRINT "Life"; life

    IF life < 0 THEN
        CLS
        LOCATE 10, 10: PRINT "Game Over"
        _DISPLAY
        _DELAY 3
        GOTO RestartGame
    END IF

    _DISPLAY
LOOP



;Microcomputer Lab: Final Project
;File Name: Ga.asm

INCLUDE MACRO_GAME.h

.MODEL HUGE
.386
.DATA
SCORE_P DD ?
MODE DB ?			;1 for EASY, 2 for NORMAL, 3 for HARD
ATTACK DW ?			;when the player is hit
SPEED0 DW ?			;1 for EASY, 2 for NORMAL, 3 for HARD
LEVELNUM DB ?		;1~?
HP DW ?				;0~1000
HPChar DB 4 DUP(?)	;CHARACTERS FOR OUTPUT

SCORE DB 'SCORE'
HEALTH DB 'HEALTH'
GAMEMODE DB 'GAMEMODE -'
LEVEL DB 'LEVEL -'
EASYM DB 'EASY'
NORMM DB 'NORMAL'
HARDM DB 'HARD'
MORES DB 'BONUS'	;BONUS stands for more score added
BLANKS DB '     '
NewWorldExplorer DB 'NEW WORLD EXPLORER'
PETC DB 'PRESS ENTER TO CONTINUE.'
PETE DB 'PRESS ESC TO EXIT.'
GMSL DB 'SELECT GAME MODE'
		DB 'EASY:   PRESS  1'
		DB 'NORMAL: PRESS  2'
		DB 'HARD:   PRESS  3'
PETR DB 'PRESS ENTER TO RESTART.'

GAMEBGINTRO DB '      In the months leading up to     ', 0Ah, 0Dh
			DB '           the Apocalypse...          ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '      some initiated a project...     ', 0Ah, 0Dh	;more and more people have escaped...
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '         Press any key to join       $', 0Ah, 0Dh

NOWY DB	'        Now you are part of the       '	;LEN = 38
NWE	DB	'         New World Explorer !         '

GAMEINTROLINE DB '--------------------------------------$'

FIGUREINTRO DB '                INTRO                 ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '    PLAYER:         METEORITE:        ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                      ', 0Ah, 0Dh
			DB '                                     $', 0Ah, 0Dh
		  
GAMECNTRL DB '                CONTROL               ', 0Ah, 0Dh
		  DB '          W for going   upward        ', 0Ah, 0Dh
		  DB '          A for going backward        ', 0Ah, 0Dh
		  DB '          S for going downward        ', 0Ah, 0Dh
		  DB '          D for going  forward        ', 0Ah, 0Dh
		  DB '                                      ', 0Ah, 0Dh
		  DB '        Score as high as U can :)     ', 0Ah, 0Dh
		  DB '               Good Luck              ', 0Ah, 0Dh
		  DB '                                     $', 0Ah, 0Dh
		  
AUTHOR DB '       BY B110300XX and B110300XX    $', 0Ah, 0Dh
		
GAMEOV DB 'GAME OVER'
END_SCORE	DB 'YOU SCORED         '	;8 blanks for score
NICEW DB 'NICE WORK!'
WLPL DB 'WELL-PLAYED!'
INCRE DB 'INCREDIBLE!'

;COLORS
BLACK EQU 00h
BLUE EQU 01h
GREEN EQU 02h
CYAN EQU 03h
RED EQU 04h
PURPLE EQU 05h
BROWN EQU 06h
GRAY EQU 07h
DARK_GRAY EQU 08h
LIGHT_BLUE EQU 09h
LIGHT_GREEN EQU 0Ah
LIGHT_CYAN EQU 0Bh
LIGHT_RED EQU 0Ch
LIGHT_PURPLE EQU 0Dh
YELLOW EQU 0Eh
WHITE EQU 0Fh

;OBJECTS
SMALL_METEORITE DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
				DB BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK
				DB BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK
				DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
				DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
				DB BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK
				DB BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK
				DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
				DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
				DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
				DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
				DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
				DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
				DB BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK
				DB BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK
				DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
				DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
				DB BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK
				DB BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK
				DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK

BIG_METEORITE	DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
		DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK

JET1 DB GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, LIGHT_CYAN, LIGHT_CYAN, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK
	DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
	DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, LIGHT_BLUE, LIGHT_BLUE, LIGHT_BLUE, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, RED, RED, BLACK, BLACK
	DB GRAY, GRAY, BLACK, BLACK, BLACK, GRAY, GRAY, LIGHT_BLUE, LIGHT_BLUE, LIGHT_BLUE, GRAY, GRAY, WHITE, WHITE, WHITE, WHITE, RED, RED, RED, RED		
	DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, LIGHT_BLUE, LIGHT_BLUE, LIGHT_BLUE, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, RED, RED, BLACK, BLACK
	DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK			
	DB BLACK, GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, LIGHT_CYAN, LIGHT_CYAN, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB GRAY, GRAY, GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB GRAY, GRAY, GRAY, GRAY, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK
	DB BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK

;Random Ys
YPOS DW 99,41,88,32,120,87,49,87,92,165,135,109,154,56,114,72,135,54,72,49,124,104,50,139,34,157,69,64,41,171,92,98
	 DW 82,52,177,62,84,161,64,47,84,97,118,102,35,175,47,121,119,63,38,159,72,152,170,165,177,83,165,83,107,97,41,57
	 DW 166,109,68,152,77,169,85,150,39,59,127,112,111,148,42,131,153,146,172,73,125,159,78,130,55,150,54,130,88,106
	 DW 90,105,147,180,101,121,57,177,111,63,131,60,156,97,116,149,33,63,151,86,107,34,115,141,129,180,141,51,57,84
	 DW 133,74,55,172,50,54,73,68,93,80,99,67,126,97,56,67,34,73,83,80,114,119,108,166,47,94,89,106,88,92,173,38,47
	 DW 141,127,76,72,132,109,169,138,38,82,60,116,163,59,144,145,154,32,122,56,160,36,63,89,116,155,104,62,51,152,102
	 DW 151,168,89,37,136,99,111,147,139,78,40,132

;PLAYER POSITION
;The dot is the (x, y)
;.___			
;|  |
;|__|
PLAYER_X DW ?				;right
PLAYER_Y DW ?				;top
STEPLENGTH EQU 15			;pixels per step

SMALL_METEORITE_X DW ?		;The x and y of the obstacle
SMALL_METEORITE_Y DW ?
SSTA DW 0					;Small M. Status
SCOUNTER DW 0050H			;Counter (Delay)
SFCOUNTER DW 0050H			;Reset Counter (Fixed)

YPOSINDEX DW 0H				;Y position index (A backup)

.STACK 100H
.CODE
.STARTUP
		SetMode 13h
		SetColor 0000b		;Black Background
		SetCursor 1, 6
		PrintStr GAMEBGINTRO	;STORYTELLING
		WaitKey
		SetMode 13h
		SetColor 0000b
		PRINTSTRING NOWY, 1, 11, 38, WHITE
		PRINTSTRING NWE, 1, 13, 38, LIGHT_CYAN
		WaitKey
		
	;FIRST PAGE
	;----------------------------------------------
	FIRSTPAGE:
		SetMode 13h
		SetColor 0000b
		PRINTSTRING NewWorldExplorer, 11, 1, 18, LIGHT_CYAN	;TITLE
		PRINTSTRING PETE, 11, 21, 18, LIGHT_GREEN			;PRESS ESC TO EXIT
		PRINTSTRING PETC, 8, 22, 24, LIGHT_GREEN			;PRESS ENTER TO CONTINUE
		SetCursor 1, 2
		PrintStr GAMEINTROLINE
		SetCursor 1, 23
		PrintStr GAMEINTROLINE
		SetCursor 1, 3
		PrintStr FIGUREINTRO
		PImage 250, 45, BIG_METEORITE, 40
		PImage 100, 55, JET1, 20
		SetCursor 1, 12
		PrintStr GAMECNTRL
		SetCursor 1, 24
		PrintStr AUTHOR
	FIRSTWAIT:
		WaitKey
		cmp al, 0Dh
			je SECONDPAGE
		cmp al, 1Bh
			je TERMINATE
		jmp FIRSTWAIT
		
	;SECOND PAGE (SELECT GAME MODE)
	;----------------------------------------------
	SECONDPAGE:
		SetMode 13h
		SetColor 0000b
		
		PRINTSTRING GMSL, 11, 07, 16, WHITE			;SHOW GAME MODE
		PRINTSTRING GMSL[16], 11, 10, 16, LIGHT_CYAN
		PRINTSTRING GMSL[32], 11, 13, 16, YELLOW
		PRINTSTRING GMSL[48], 11, 16, 16, PURPLE
		
	SETGAMEMODE:										;SELECT GAME MODE
		WaitKey
		cmp al, 1Bh
			je TERMINATE
		cmp al, '1'
			je MODE1
		cmp al, '2'
			je MODE2
		cmp al, '3'
			je MODE3
		jmp SETGAMEMODE
	MODE1:
		mov MODE, 1
		jmp THIRDPAGE
	MODE2:
		mov MODE, 2
		jmp THIRDPAGE
	MODE3:
		mov MODE, 3
		jmp THIRDPAGE
		
	;THIRD PAGE (GAME STARTS)
	;----------------------------------------------
	THIRDPAGE:
		SetMode 13h
		SetColor 0000b
		call GAME_RESET				;RESET HP, SCORE, etc
		call INITIALIZE_GAME		;GAME INFO ON THE TOP
	InfLoop:
		call DRAWFRAME
		COUNT SCOUNTER, SFCOUNTER, SMALL_METEORITE_X, SMALL_METEORITE_Y, 20, SSTA
		MOVEOBSTACLE SMALL_METEORITE, SMALL_METEORITE_X, SMALL_METEORITE_Y, 20, SPEED0, SSTA
		COLLISION_TEST SMALL_METEORITE, SMALL_METEORITE_X, SMALL_METEORITE_Y, 20, SSTA
		
		MOV AX, 0			;PRECAUTION
		GetKey
		call KEY_ACTIONS
		call ADDSCORE
		SetCursor 31, 2
		call UPDATESCORE
		CalcDec HP			;HP FROM HEX. TO DEC.
		PRINTSTRING HPChar, 2, 2, 4, RED
		call CHECK_HEALTH
		call SPEEDUP
		;PRINTSTRING LEVELNUM, 23, 2, 1, LIGHT_BLUE
		SetCursor 23, 2		;FOR EFFICIENCY
		PrintChar LEVELNUM
		jmp InfLoop
		
	;FOURTH PAGE (GAME OVER)
	;----------------------------------------------
	FOURTHPAGE:
		call GAMEOVER
	WaitForAnswer:
		WaitKey
		cmp al, 1Bh
			je TERMINATE
		cmp al, 0Dh
			je FIRSTPAGE
		jmp WaitForAnswer
			
	TERMINATE:	
		SetMode 03h
.EXIT

SPEEDUP PROC
		CMP MODE, 3
			JE HARD
		CMP MODE, 2
			JE NORMAL
;-------------------EASY
		CMP SCORE_P, 1000H
			JA ELEVEL2
		RET
	ELEVEL2:
		MOV LEVELNUM, 32H
		MOV SPEED0, 2
		CMP SCORE_P, 1D00H
			JA ELEVEL3
		RET
	ELEVEL3:
		MOV LEVELNUM, 33H
		MOV SPEED0, 3
		RET
;-------------------NORMAL	
	NORMAL:
		CMP SCORE_P, 1D00H
			JA NLEVEL2
		RET
	NLEVEL2:
		MOV LEVELNUM, 32H
		MOV SPEED0, 3
		CMP SCORE_P, 2B00H
			JA NLEVEL3
		RET
	NLEVEL3:
		MOV LEVELNUM, 33H
		MOV SPEED0, 4
		RET
;-------------------HARD
	HARD:
		CMP SCORE_P, 2B00H
			JA HLEVEL2
		RET
	HLEVEL2:
		MOV LEVELNUM, 32H
		MOV SPEED0, 4
		CMP SCORE_P, 3B00H
			JA HLEVEL3
		RET
	HLEVEL3:
		MOV LEVELNUM, 33H
		MOV SPEED0, 5
		CMP SCORE_P, 4B00H
			JA HLEVEL4
		RET
	HLEVEL4:
		MOV LEVELNUM, 34H
		MOV SPEED0, 7
		CMP SCORE_P, 5B00H
			JA HLEVEL5
		RET
	HLEVEL5:
		MOV LEVELNUM, 35H
		MOV SPEED0, 9
		RET
SPEEDUP ENDP

CHECK_HEALTH PROC
		CMP HP, 0
			JNLE NOTDIE
		JMP FOURTHPAGE
	NOTDIE:		
		RET
CHECK_HEALTH ENDP

KEY_ACTIONS PROC USES ax bx cx dx
		;IDENTIFY THE KEY PRESSED
        CMP AL, 77H
			JE UP    			;w      
        CMP AL, 57H
			JE UP     			;W

        CMP AL, 61H
			JE LEFT   			;a      
        CMP AL, 41H
			JE LEFT   			;A

        CMP AL, 73H
			JE DOWN				;s     
        CMP AL, 53H
			JE DOWN				;S

        CMP AL, 64H
			JE RIGHT			;d      
        CMP AL, 44H
			JE RIGHT			;D
		
		CMP AL, 1Bh
			JE TERMINATE
		CMP AL, 0Dh
			JE FOURTHPAGE
		RET
		;CHECK POSITION BEFORE MOVING
	UP:
		MOV AX, PLAYER_Y
		CMP AX, 31
			JLE CANNOTMOVE
		DISPImage PLAYER_X, PLAYER_Y, JET1, 20
		SUB PLAYER_Y, STEPLENGTH
		PImage PLAYER_X, PLAYER_Y, JET1, 20
		COLLISION_TEST SMALL_METEORITE, SMALL_METEORITE_X, SMALL_METEORITE_Y, 20, SSTA
		RET
	LEFT:
		MOV AX, PLAYER_X
		CMP AX, 11
			JLE CANNOTMOVE
		DISPImage PLAYER_X, PLAYER_Y, JET1, 20
		SUB PLAYER_X, STEPLENGTH
		PImage PLAYER_X, PLAYER_Y, JET1, 20
		COLLISION_TEST SMALL_METEORITE, SMALL_METEORITE_X, SMALL_METEORITE_Y, 20, SSTA
		RET
	DOWN:
		MOV AX, PLAYER_Y
		CMP AX, 180
			JGE CANNOTMOVE
		DISPImage PLAYER_X, PLAYER_Y, JET1, 20
		ADD PLAYER_Y, STEPLENGTH
		PImage PLAYER_X, PLAYER_Y, JET1, 20
		COLLISION_TEST SMALL_METEORITE, SMALL_METEORITE_X, SMALL_METEORITE_Y, 20, SSTA
		RET
	RIGHT:
		MOV AX, PLAYER_X
		CMP AX, 280
			JGE CANNOTMOVE
		DISPImage PLAYER_X, PLAYER_Y, JET1, 20
		ADD PLAYER_X, STEPLENGTH
		PImage PLAYER_X, PLAYER_Y, JET1, 20
		COLLISION_TEST SMALL_METEORITE, SMALL_METEORITE_X, SMALL_METEORITE_Y, 20, SSTA
		RET
		
	CANNOTMOVE: 
		RET
KEY_ACTIONS ENDP

UPDATESCORE PROC USES AX BX CX DX	;PRINT HEX. NUMBERS
LOCAL n1: word, n2: word, temp: byte
		mov cl, 16
		mov eax, SCORE_P
		shr eax, cl
		mov n1, ax
		mov eax, SCORE_P
		shl eax, cl
		shr eax, cl
		mov n2, ax
		
		mov cl, 4
	P1:
		mov ax, n1
		shr ah, cl
		cmp	ah, 10
			jae PHex1
		add ah, 30h
		mov temp, ah
		PrintChar temp
		jmp P2
	PHex1:
		add ah, 55		;10+55=65 (0Ah+37h=41h)
		mov temp, ah
		PrintChar temp

	P2:
		mov ax, n1
		shl ah, cl
		shr ah, cl
		cmp	ah, 10
			jae PHex2
		add ah, 30h
		mov temp, ah
		PrintChar temp
		jmp P3
	PHex2:
		add ah, 55		;10+55=65 (0Ah+37h=41h)
		mov temp, ah
		PrintChar temp

	P3:
		mov ax, n1
		shr al, cl
		cmp	al, 10
			jae PHex3
		add al, 30h
		PrintChar al
		jmp P4
	PHex3:
		add al, 55		;10+55=65 (0Ah+37h=41h)
		PrintChar al

	P4:
		mov ax, n1
		shl al, cl
		shr al, cl
		cmp	al, 10
			jae PHex4
		add al, 30h
		PrintChar al
		jmp P5
	PHex4:
		add al, 55		;10+55=65 (0Ah+37h=41h)
		PrintChar al
		
	P5:
		mov ax, n2
		shr ah, cl
		cmp	ah, 10
			jae PHex5
		add ah, 30h
		mov temp, ah
		PrintChar temp
		jmp P6
	PHex5:
		add ah, 55		;10+55=65 (0Ah+37h=41h)
		mov temp, ah
		PrintChar temp

	P6:
		mov ax, n2
		shl ah, cl
		shr ah, cl
		cmp	ah, 10
			jae PHex6
		add ah, 30h
		mov temp, ah
		PrintChar temp
		jmp P7
	PHex6:
		add ah, 55		;10+55=65 (0Ah+37h=41h)
		mov temp, ah
		PrintChar temp

	P7:
		mov ax, n2
		shr al, cl
		cmp	al, 10
			jae PHex7
		add al, 30h
		PrintChar al
		jmp P8
	PHex7:
		add al, 55		;10+55=65 (0Ah+37h=41h)
		PrintChar al

	P8:
		mov ax, n2
		shl al, cl
		shr al, cl
		cmp	al, 10
			jae PHex8
		add al, 30h
		PrintChar al
		jmp Finish
	PHex8:
		add al, 55		;10+55=65 (0Ah+37h=41h)
		PrintChar al

	Finish:
		ret
UPDATESCORE ENDP

INITIALIZE_GAME PROC
		PImage PLAYER_X, PLAYER_Y, JET1, 20
		PRINTSTRING GAMEMODE, 12, 1, 10, LIGHT_CYAN
		CMP MODE, 1
			JE PE
		CMP MODE, 2
			JE PN
		CMP MODE, 3
			JE PH
	PE:
		PRINTSTRING EASYM, 23, 1, 4, LIGHT_CYAN
		JMP FINISH
	PN:
		PRINTSTRING NORMM, 23, 1, 6, LIGHT_CYAN
		JMP FINISH
	PH:
		PRINTSTRING HARDM, 23, 1, 4, LIGHT_CYAN
	FINISH:
		PRINTSTRING SCORE, 31, 1, 5, YELLOW
		PRINTSTRING HEALTH, 1, 1, 6, LIGHT_PURPLE
		PRINTSTRING LEVEL, 15, 2, 7, LIGHT_BLUE
		RET
INITIALIZE_GAME ENDP

DRAWFRAME PROC USES AX CX DX
        MOV AH, 0CH				;Draw Frame
        MOV AL, 0Fh

        MOV CX, 320D
        MOV DX, 30D
	UPPER_FRAME: 
		INT 10H
        LOOP UPPER_FRAME
                        
        MOV CX, 319D
        MOV DX, 199D
	LOWER_FRAME:
		INT 10H
        LOOP LOWER_FRAME

        MOV CX, 319D
        MOV DX, 199D
    RIGHT_FRAME: 
		INT 10H
        DEC DX 
        CMP DX, 30D
			JNZ RIGHT_FRAME
                        
        MOV CX, 0
    LEFT_FRAME:
		INT 10H
        INC DX 
        CMP DX, 199D
			JNZ LEFT_FRAME
		RET
DRAWFRAME ENDP

ADDSCORE PROC USES EAX EBX				;according to player position and game mode
		CMP PLAYER_X, 115
			JB NOBONUS
		CMP MODE, 1
			JE add2
		CMP MODE, 2
			JE add4
		CMP MODE, 3
			JE add6
	add2:
		ADD SCORE_P, 2
		PRINTSTRING MORES, 8, 2, 5, LIGHT_GREEN
		JMP CONT
	add4:
		ADD SCORE_P, 4
		PRINTSTRING MORES, 8, 2, 5, LIGHT_GREEN
		JMP CONT
	add6:
		ADD SCORE_P, 6
		PRINTSTRING MORES, 8, 2, 5, LIGHT_GREEN
		JMP CONT
	NOBONUS:
		PRINTSTRING BLANKS, 8, 2, 5, BLACK
	CONT:
		mov eax, 0
		mov al, mode
		cmp al, 1
			je EASY
		cmp al, 2
			je NORMAL
		cmp al, 3
			je HARD
	EASY:
		add SCORE_P, eax
		JMP FINISH
	NORMAL:
		add SCORE_P, eax
		JMP FINISH
	HARD:
		add SCORE_P, eax
		JMP FINISH
	FINISH:
		RET
ADDSCORE ENDP

GAME_RESET PROC USES AX BX CX DX
		mov HP, 2022
		mov SCORE_P, 0
		mov PLAYER_X, 40		;Initial Player position
		mov PLAYER_Y, 106		;30 + (200-30)/2
		MOV LEVELNUM, 31H
		
		MOV AH, 2CH
		INT 21H		;GET SYSTEM TIME
		SHR DX, 8	;DISCARD DL, DX = DH (SEC)
		MOV BX, DX	;BX = SEC
		ADD DX, DX	;DL = SEC*2
		ADD BX, DX	;BX = 3*SEC
		ADD BX, BX	;BX = 6*SEC (YPOS[2*3*SEC] TO ADDRESS THE Y POSITION)
		MOV YPOSINDEX, BX
		
		cmp MODE, 1
			je EA
		cmp MODE, 2
			je NO
		cmp MODE, 3
			je HA
	EA:
		mov ATTACK, 506
		mov SPEED0, 1
		mov SFCOUNTER, 0120H
		jmp TER
	NO:
		mov ATTACK, 675
		mov SPEED0, 2
		mov SFCOUNTER, 0090H
		jmp TER
	HA:
		mov ATTACK, 1011
		mov SPEED0, 3
		mov SFCOUNTER, 0060H
		jmp TER
	TER:
		MOV AX, SFCOUNTER
		MOV SCOUNTER, AX
		RET
GAME_RESET ENDP

GAMEOVER PROC
		SetMode 13h
		SetColor 0000b
		PRINTSTRING GAMEOV, 15, 2, 9, LIGHT_BLUE	;SHOW GAME OVER
		PRINTSTRING GAMEMODE, 12, 5, 10, BROWN
		PRINTSTRING LEVEL, 15, 8, 7, GRAY
		PRINTSTRING LEVELNUM, 23, 8, 1, GRAY
		CMP MODE, 1
			JE PE
		CMP MODE, 2
			JE PN
		CMP MODE, 3
			JE PH
	PE:
		PRINTSTRING EASYM, 23, 5, 4, BROWN
		JMP FINISH
	PN:
		PRINTSTRING NORMM, 23, 5, 6, BROWN
		JMP FINISH
	PH:
		PRINTSTRING HARDM, 23, 5, 4, BROWN
	FINISH:
		PRINTSTRING END_SCORE, 10, 11, 19, WHITE	;SHOW SCORE
		SetCursor 21, 11
		call UPDATESCORE							;PRINT SCORE
		CMP MODE, 1
			JE EASY
		CMP MODE, 2
			JE NORMAL
		CMP MODE, 3
			JE HARD
	EASY:
		CMP SCORE_P, 0A000h
			JAE WP
		CMP SCORE_P, 7000h
			JAE NW
			JMP NEXT
	NORMAL:
		CMP SCORE_P, 8000h
			JAE WP
		CMP SCORE_P, 5000h
			JAE NW
			JMP NEXT
	HARD:
		CMP SCORE_P, 0A000h
			JAE INCR
		CMP SCORE_P, 6000h
			JAE WP
		CMP SCORE_P, 3000h
			JAE NW
			JMP NEXT
	INCR:
		PRINTSTRING INCRE, 14, 14, 11, LIGHT_CYAN
		JMP NEXT
	WP:
		PRINTSTRING WLPL, 14, 14, 12, LIGHT_GREEN
		JMP NEXT
	NW:
		PRINTSTRING NICEW, 15, 14, 10, LIGHT_PURPLE
	NEXT:
		;SHOW LEVEL
		PRINTSTRING PETE, 11, 23, 18, LIGHT_RED		;PRESS ESC TO EXIT
		PRINTSTRING PETR, 9, 24, 23, LIGHT_RED	;PRESS ENTER TO RESTART
		RET
GAMEOVER ENDP

END
;File Name: MACRO_GAME.h

SetMode macro mode    	;03h for text or 12h for graphics
        mov ah, 00h
        mov al, mode
        int 10h
        endm
		
SetColor macro color	;Set Background Color
        mov ah, 0bh 
        mov bh, 00h
        mov bl, color
        int 10h
        endm
		 
SetCursor macro col, row	;Set Cursor(Position)
		push dx
		push bx
        mov dh, row
        mov dl, col
        mov bx, 00h
        mov ah, 02h
        int 10h
		pop bx
		pop dx
        endm
		  
PrintStr macro string	;Print String
        mov ah, 09h
        mov dx, offset string
        int 21h
        endm

PrintChar macro char		;Print Char
        mov ah, 02h
        mov dl, char
        int 21h
        endm
		 
GetKey macro         	;This does not wait
		push dx
		mov ah, 06h
		mov dl, 0ffh
		int 21h
		pop dx
        endm
		
WaitKey macro
		mov ah, 10h
        int 16h
		endm
		
CalcDec macro num
		push ax
		push bx
		push dx
		
		mov bx, 0Ah
		
		mov dx, 0
		mov ax, num
		div bx
		add dx, 30h
		mov HPChar[3], dl
		
		mov dx, 0
		div bx
		add dx, 30h
		mov HPChar[2], dl
		
		mov dx, 0
		div bx
		add dx, 30h
		mov HPChar[1], dl
		
		mov dx, 0
		div bx
		add dx, 30h
		mov HPChar[0], dl
		
		pop dx
		pop bx
		pop ax
		endm

PRINTSTRING macro str, x0, y0, len, color
LOCAL PRINTSTR
		push ax
		push bx
		push dx
		push si
		push di
		
        mov dl, x0 				;move the cursor
		mov dh, y0
		mov bh, 0
		mov ah, 02h
		int 10h

        mov bl, color
		mov ah, 0Eh
		mov di, len
		mov si, 0
		
	PRINTSTR:
        mov al, str[si]
        int 10h
        inc dl					;moving the cursor right
        inc si					;next char
        dec di
			jnz PRINTSTR
			
		pop di
		pop si
		pop dx
		pop bx
		pop ax
		endm
		
PImage MACRO PARAX, PARAY, ITEM, SIZE	;PRINT IMAGE
LOCAL L1, L2, NEXT, NOP
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		 
		LEA DI, ITEM
		MOV CX, PARAX
		MOV DX, PARAY
	L1:
		MOV AL, BYTE PTR [DI]
		MOV AH, 0CH
		MOV BH, 0
		CMP AL, 0H
		JE NOP
		INT 10H
	NOP:
		INC CX
		INC DI
		PUSH CX
		SUB CX, PARAX
		CMP CX, SIZE
		JE L2
		POP CX
		JMP L1
	L2:
		POP CX
		MOV CX, PARAX
		INC DX
		PUSH DX
		SUB DX, PARAY
		CMP DX, SIZE
		JE NEXT
		POP DX
		JMP L1
	NEXT:
		POP DX
		POP DX
		POP CX
		POP BX
		POP AX
		ENDM
		
DISPImage MACRO PARAX, PARAY, ITEM, SIZE	;DISAPPEAR_PIMAGE
LOCAL L1, L2, NEXT, NOP
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		 
		LEA DI, ITEM
		MOV CX, PARAX
		MOV DX, PARAY
	L1:
		MOV AL, BYTE PTR [DI]
		MOV AH, 0CH
		MOV BH, 0
		CMP AL, 0H
		JE NOP
		MOV AL, 0H
		INT 10H
	NOP:
		INC CX
		INC DI
		PUSH CX
		SUB CX, PARAX
		CMP CX, SIZE
		JE L2
		POP CX
		JMP L1
	L2:
		POP CX
		MOV CX, PARAX
		INC DX
		PUSH DX
		SUB DX, PARAY
		CMP DX, SIZE
		JE NEXT
		POP DX
		JMP L1
	NEXT:
		POP DX
		POP DX
		POP CX
		POP BX
		POP AX
		ENDM
		
MOVEOBSTACLE MACRO ITEM, ITEMX, ITEMY, SIZE, STEP, STA
LOCAL MOVE, EXIT, L1, KEEPMOVING
		CMP STA, 0
			JE EXIT
	MOVE:
		MOV SI,	STEP
	L1:
		DISPIMAGE ITEMX, ITEMY, ITEM, SIZE
		CMP ITEMX, 2
			JA KEEPMOVING
		MOV STA, 0
		JMP EXIT
	KEEPMOVING:
		SUB ITEMX, 2		;2 pixels per step
		PIMAGE ITEMX, ITEMY, ITEM ,SIZE
		DEC SI
		CMP SI, 0H
			JA L1			
EXIT:
	ENDM

COLLISION_TEST MACRO ITEM, ITEMX, ITEMY, SIZE, STATUS
LOCAL TER
		PUSH AX
		PUSH BX
		CMP STATUS, 0
			JE TER
		MOV AX, PLAYER_X
		MOV BX, ITEMX
		ADD AX, 19
		CMP AX, BX
			JB TER
		MOV AX, PLAYER_X
		MOV BX, ITEMX
		ADD BX, SIZE
		DEC BX
		CMP AX, BX
			JA TER
		MOV AX, PLAYER_Y
		ADD AX, 19
		MOV BX, ITEMY
		CMP AX, BX
			JB TER
		MOV AX, PLAYER_Y
		MOV BX, ITEMY
		ADD BX, SIZE
		DEC BX
		CMP AX, BX
			JA TER
		MOV AX, ATTACK
		SUB HP, AX
		MOV STATUS, 0H
		DISPIMAGE ITEMX, ITEMY, ITEM, SIZE
		PImage PLAYER_X, PLAYER_Y, JET1, 20
	TER:
		POP BX
		POP AX
		ENDM
	
COUNT MACRO COUNTER, FCOUNTER, ITEMX, ITEMY, SIZE, STA
LOCAL READY, EXIT
		PUSH AX
		PUSH SI
		CMP STA, 1
			JE EXIT
		CMP COUNTER, 0
			JE READY
		DEC COUNTER
		JMP EXIT
	READY:
		MOV STA, 1
		MOV AX, FCOUNTER	;RESET COUNTER
		MOV COUNTER, AX
		MOV ITEMX, 320		;SET ITEMX
		SUB ITEMX, SIZE
		INC ITEMX
		MOV SI, YPOSINDEX	;RESTORE THE INDEX
		MOV AX, YPOS[SI]
		MOV ITEMY, AX		;SET Y (RANDOM)
		ADD YPOSINDEX, 2
		CMP YPOSINDEX, 400			;IF SI == 400, THEN RESET THE INDEX
			JB EXIT
		MOV YPOSINDEX, 0
	EXIT:		
		POP SI
		POP AX
		ENDM
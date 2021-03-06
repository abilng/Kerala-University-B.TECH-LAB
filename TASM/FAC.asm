ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	MSG1 DB "enter number(<7):$"
	MSG2 DB 0AH,0DH,"ans=:$"
	A DB 1
	B DB 1
	c DB 1
	HUN DB 64H
	TEN DB 0AH
DATA ENDS

CODE SEGMENT
START:	MOV AX,DATA
	MOV DS,AX
	MOV AH,09H
	LEA DX,MSG1
	INT 21H
	MOV AH,01H
	INT 21H
	SUB AL,30H
	MOV BL,AL
	CMP AL,00H
	JZ L
	CMP AL,01H
	JZ L
	XOR AH,AH
	MOV AL,BL
	MOV CX,AX
	DEC CX

FAT:	MUL CX
	DEC CX
	JNZ FAT

	MOV CX,AX
	LEA DX,MSG2
	MOV AH,09H
	INT 21H

	XOR BH,BH
	MOV AX,CX
	DIV HUN
	MOV BX,AX
	MOV AL,BL
	XOR AH,AH
	DIV TEN
	MOV A,AL
	MOV B,AH
	MOV AL,BH
	XOR AH,AH
	DIV TEN
	MOV CX,AX
	ADD CH,30H
	ADD CL,30H
	MOV AH,02H
	MOV DL,A
	ADD DL,30H
	INT 21H
	MOV DL,B
	ADD DL,30H
	INT 21H
	MOV AH,02H
	MOV DL,CL
	INT 21H
	MOV AH,02H
	MOV DL,CH
	INT 21H
	JMP L1

L:	MOV AH,09H
	LEA DX,MSG2
	INT 21H
	MOV AH,02H
	MOV DL,31H
	INT 21H
L1:	MOV AH,4CH
	INT 21H

CODE ENDS
END START

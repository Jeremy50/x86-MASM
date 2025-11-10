; Calculate (A + B) - (C + D) using signed and unsigned types

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	sum     DWORD  0
	valueA  DWORD  -2000
	valueB  DWORD  100
	valueC  DWORD  1000
	valueD  DWORD  -500

	ssum    SDWORD 0
	svalueA SDWORD -2000
	svalueB SDWORD 100
	svalueC SDWORD 1000
	svalueD SDWORD -500

.code
main proc

	MOV EAX, valueA
	ADD EAX, valueB
	MOV EBX, valueC
	ADD EBX, valueD
	SUB EAX, EBX
	MOV sum, EAX

	MOV EAX, svalueA
	ADD EAX, svalueB
	MOV EBX, svalueC
	ADD EBX, svalueD
	SUB EAX, EBX
	MOV ssum, EAX

	invoke ExitProcess, 0

main endp
end main
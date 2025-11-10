; Generate random numbers between an upper and lower bound

include Irvine32.inc
includelib Irvine32.lib

.data
UBpromptMessage BYTE "Enter the upper bound: ", 0
LBpromptMessage BYTE "Enter the lower bound: ", 0

.code

BetterRandomRange PROC uses EAX EBX
	sub eax, ebx
	call RandomRange
	add eax, ebx
	call WriteInt
	call Crlf
	ret
BetterRandomRange ENDP

promptRange PROC

	mov edx, OFFSET LBpromptMessage
	call WriteString
	call ReadInt
	mov ebx, eax

	mov edx, OFFSET UBpromptMessage
	call WriteString
	call ReadInt

	ret

promptRange ENDP

main PROC

	mov ecx, 3
	L1:

		call promptRange

		mov edx, ecx

		mov ecx, 30
		L2:
			call BetterRandomRange
			loop L2

		mov ecx, edx
		loop L1
	
	exit

main ENDP
end main
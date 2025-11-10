; Input and reverse an array using the stack and a library

include Irvine32.inc
includelib Irvine32.lib

.data
inputMessage BYTE "Enter a string within 50 chars: ", 0
string BYTE 51 DUP(0)
byteCount DWORD ?

.code
main proc

    mov  edx, OFFSET inputMessage
	call WriteString

	mov edx, offset string
	mov ecx, sizeof string
	call ReadString
	mov byteCount, eax

    mov  edx, OFFSET string
	call WriteString
	call Crlf

	mov	 ecx, byteCount
	mov	 esi, 0
	l1:
		movzx eax, string[esi]
		push eax
		inc	 esi
		loop l1

	mov	 ecx, byteCount
	mov	 esi, 0
	l2:
		pop  eax
		mov	 string[esi], al
		inc	 esi
		loop l2

	mov  edx, OFFSET string
	call WriteString
	call Crlf

	exit

main endp
end main
; Encode and Decode a string using ROL and ROR

include Irvine32.inc
includelib Irvine32.lib

.data
MAXSIZE = 128
textPrmpt byte "Please enter one plain text:", 0
encDisp   byte "The plain text after encoded:", 0
decDisp   byte "The plain text after decoded:", 0
buf byte MAXSIZE dup(0)
key sbyte -5, 3, 2, -3, 0, 5, 2, -4, 7, 9

.code
main proc
	call Prompt
	call Encode
	call Decode
	exit
main endp

Prompt proc

	mov edx, offset textPrmpt
	call WriteString
	call Crlf

	mov edx, offset buf
	mov ecx, sizeof buf
	call ReadString
	call Crlf
	ret

Prompt endp

Encode proc

	mov esi, offset buf
	mov edi, 0
	mov ecx, sizeof buf
	
	L1:

		push ecx
		mov cl, key[edi]
		mov al, [esi]
		rol al, cl
		mov [esi], al
		pop ecx

		inc esi
		inc edi
		cmp edi, sizeof key
		
		jne E1
			mov edi, 0
		E1:
			loop L1

	mov edx, offset encDisp
	call WriteString
	call Crlf

	mov edx, offset buf
	call WriteString
	call Crlf
	call Crlf
	ret

Encode endp

Decode proc

	mov esi, offset buf
	mov edi, 0
	mov ecx, sizeof buf
	
	L1:

		push ecx
		mov cl, key[edi]
		mov al, [esi]
		ror al, cl
		mov [esi], al
		pop ecx

		inc esi
		inc edi
		cmp edi, sizeof key
		
		jne E1
			mov edi, 0
		E1:
			loop L1

	mov edx, offset decDisp
	call WriteString
	call Crlf

	mov edx, offset buf
	call WriteString
	call Crlf
	ret

Decode endp

end main
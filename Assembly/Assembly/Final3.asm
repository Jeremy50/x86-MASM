; Final Exam

include Irvine32.inc
includelib Irvine32.lib

.data
targetStr byte "ABCDE", 10 dup(0)
sourceStr byte "FGH", 0

.code
Str_concat proto targetPtr:ptr byte, sourcePtr:ptr byte
GetEndStr proto strPtr:ptr byte

main proc

	mov edx, offset targetStr
	call WriteString
	call Crlf

	invoke Str_concat, addr targetStr, addr sourceStr

	mov edx, offset targetStr
	call WriteString
	call Crlf

	exit

main endp

Str_concat proc targetPtr:ptr byte, sourcePtr:ptr byte

	; Find length of source
	mov edi, sourcePtr
	mov al, 0
	mov ecx, 0FFFFFFFFh

	cld
	repne scasb
	dec edi
	sub edi, sourcePtr
	push edi

	; Move to end of target
	mov edi, targetPtr
	mov al, 0
	mov ecx, 0FFFFFFFFh

	cld
	repne scasb
	dec edi

	; Copy source to end of target
	mov esi, sourcePtr
	pop ecx
	rep movsb

	ret

Str_concat endp


end main
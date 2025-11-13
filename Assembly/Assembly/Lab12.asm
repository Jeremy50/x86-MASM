; Subtract two integers, each with a size larger than 32 bits

include Irvine32.inc
includelib Irvine32.lib

.data
a qword 0A2B2A40674981234h
b qword 080108700B0234502h
r qword 1 dup(0)
msg byte "The difference equals ", 0
num_dwords = sizeof a / type dword

.code
main PROC

	mov esi, offset a
	mov edi, offset b
	mov ebx, offset r
	mov ecx, num_dwords
	call ExtendedSub

	mov edx, offset msg
	call WriteString

	mov esi, offset r
	add esi, num_dwords * type dword
	mov ecx, num_dwords

	L1:
		sub esi, type dword
		mov eax, [esi]
		call WriteHex
		loop L1

	call Crlf
	exit

main ENDP

ExtendedSub proc
	mov edx, 0
	clc
	L1:
		mov eax, [esi + edx]
		sbb eax, [edi + edx]
		mov [ebx + edx], eax
		pushf
		add edx, type dword
		popf
		loop L1
	ret
ExtendedSub endp

end main
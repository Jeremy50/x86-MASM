; Reverse and Unreverse a non-byte array using indexed and indirect addressing

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	array WORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

.code
main proc

	mov esi, 0
	mov edi, SIZEOF array - TYPE array
	mov ecx, edi
	shr ecx, TYPE array

	INDEXED:
		xchg ax, array[esi]
		xchg ax, array[edi]
		xchg ax, array[esi]
		add esi, TYPE array
		sub edi, TYPE array
		loop INDEXED

	mov esi, OFFSET array
	mov edi, SIZEOF array - TYPE array
	mov ecx, edi
	shr ecx, TYPE array
	add edi, esi

	INDIRECT:
		xchg ax, [esi]
		xchg ax, [edi]
		xchg ax, [esi]
		add esi, TYPE array
		sub edi, TYPE array
		loop INDIRECT

invoke ExitProcess, 0

main endp
end main
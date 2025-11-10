; Swap values for static array using XCHG

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	arrayD DWORD 1, 2, 3, 4

.code
main proc
	
	mov eax, [arrayD]
	xchg [arrayD+12], eax
	mov [arrayD], eax

	mov eax, [arrayD+4]
	xchg [arrayD+8], eax
	mov [arrayD+4], eax

invoke ExitProcess, 0

main endp
end main
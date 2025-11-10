; Copy and reverse an array using indirect addressing

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
	source BYTE "This is the source string", 0
	target BYTE SIZEOF source DUP(0), 0

.code
main proc

	mov ecx, SIZEOF source
	dec ecx

	mov esi, OFFSET source
	add esi, ecx
	dec esi

	mov edi, OFFSET target

reverse_copy:

	mov al, [esi]
	mov [edi], al

	dec esi
	inc edi

	loop reverse_copy
	mov BYTE ptr [edi], 0

	invoke ExitProcess, 0


invoke ExitProcess, 0

main endp
end main
include Irvine32.inc
includelib Irvine32.lib

.data
array dword 11, 12, 13, 14, 15, 16, 17, 18, 19, 20

.code

main PROC

	mov esi, offset array
	mov ecx, lengthof array
	mov ebx, type array
	call DumpMem

	mov ecx, lengthof array - 1
	mov ebx, array[ecx * type array]
	L1:
		mov eax, dword ptr array[ecx * type array - type array]
		mov array[ecx * type array], eax
		loop L1
	mov array, ebx

	mov esi, offset array
	mov ecx, lengthof array
	mov ebx, type array
	call DumpMem

	exit

main ENDP
end main
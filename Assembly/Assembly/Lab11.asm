; Perform left shift on an array of DWORDs

include Irvine32.inc
includelib Irvine32.lib

.data
msg byte "Enter the number of bits shift to the left using SHLD: ", 0
array dword 4BC94530h, 2CBA9429h, 4FB54386h, 69FC0544h, 5F5BE7ACh
count byte ?

.code
main PROC

	call SetCount
	call LShift
	call Display

	exit

main ENDP

SetCount PROC uses eax
	mov edx, offset msg
	call WriteString
	call ReadInt
	mov count, al
	ret
SetCount ENDP

LShift PROC uses esi ecx ebx

	mov bl, count
	mov esi, offset array
	mov ecx, (lengthof array) - 1

	L1:
		push ecx
		mov cl, bl
		shld [esi], eax, cl
		add esi, type dword
		pop ecx
		loop L1

	mov cl, bl
	shl dword ptr [esi], cl

	ret

LShift ENDP

Display PROC uses esi ecx ebx
	mov esi, offset array
	mov ecx, lengthof array
	mov ebx, type array
	call DumpMem
	ret
Display ENDP

end main
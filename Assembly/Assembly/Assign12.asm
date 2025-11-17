; Add two decimal integers of arbitrary size

include Irvine32.inc
includelib irvine32.lib

.data
packed_1a word 4536h
packed_1b word 7297h
sum_1 dword 32 dup(0)

packed_2a dword 67345620h
packed_2b dword 54496342h
sum_2 dword 32 dup(0)

packed_3a qword 6734562000346521h
packed_3b qword 5449634205738261h
sum_3 dword 32 dup(0)

hit_nz byte 0


.code
main proc

	mov esi, offset packed_1a
	mov edi, offset packed_1b
	mov edx, offset sum_1
	mov ecx, sizeof packed_1a
	call AddPacked

	mov esi, offset packed_2a
	mov edi, offset packed_2b
	mov edx, offset sum_2
	mov ecx, sizeof packed_2a
	call AddPacked

	mov esi, offset packed_3a
	mov edi, offset packed_3b
	mov edx, offset sum_3
	mov ecx, sizeof packed_3a
	call AddPacked

	exit

main endp

AddPacked proc

	mov eax, 0
	mov ebx, 0
	push ecx

	clc
	pushf

	L1:

		popf
		mov al, byte ptr [esi+ebx]
		adc al, byte ptr [edi+ebx]
		daa
		mov byte ptr [edx+ebx], al
		pushf

		inc ebx
		loop L1

	popf
	mov al, 0
	pushf
	adc al, 0
	popf
	mov byte ptr [edx+ebx], al

	pop ecx
	jnc L2
	inc ecx
	mov hit_nz, 0

	L2:

		mov eax, 0
		mov al, byte ptr [edx+ebx]

		push eax
		and al, 11110000b
		shr al, 4
		call Disp
		pop eax

		and al, 1111b
		call Disp

		dec ebx
		loop L2

	call Crlf

	ret

AddPacked endp

Disp proc

	cmp al, 0
	jnz L1
	cmp hit_nz, 0
	je L2

	L1:
		call WriteDec
		mov hit_nz, 1
	L2: ret

Disp endp

end main
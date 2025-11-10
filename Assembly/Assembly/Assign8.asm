; Generate 20 random strings

include Irvine32.inc
includelib Irvine32.lib

.data
randomString BYTE 100 DUP(0)

.code

CreateRandomString PROC uses eax ecx esi
	mov ecx, eax
	L1:
		mov eax, 5Ah - 41h + 1
		call RandomRange
		add eax, 41h
		mov byte ptr [esi], al
		add esi, 1
		loop L1
	ret
CreateRandomString ENDP

Reset PROC
	mov ecx, eax
	L1:
		mov byte ptr [esi], 0
		add esi, 1
		loop L1
	ret
Reset ENDP

main PROC

	call Randomize

	mov ecx, 20
	L2:
		mov eax, 100 - 1
		call RandomRange
		add eax, 1

		mov esi, offset randomString
		call CreateRandomString

		mov ebx, ecx
		mov edx, offset randomString
		mov ecx, lengthof randomString
		call WriteString
		call Crlf
		call Reset

		mov ecx, ebx
		loop L2

	exit

main ENDP
end main
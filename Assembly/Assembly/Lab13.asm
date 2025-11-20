; Add random numbers to an array in using 3 different parameter-passing methods

include irvine32.inc
includelib irvine32.lib

.data
count = 25
upper = 200
lower = -100
array dword count dup(0)
out1 byte "=== The output from ArrayFill1 ===", 0
out2 byte "=== The output from ArrayFill2 ===", 0
out3 byte "=== The output from ArrayFill3 ===", 0

.code
main proc

	push offset array
	push count
	push upper
	push lower
	call ArrayFill1
	mov edx, offset out1
	call DispArray
	call Crlf

	push offset array
	push count
	push upper
	push lower
	call ArrayFill2
	mov edx, offset out2
	call DispArray
	call Crlf

	push offset array
	push count
	push upper
	push lower
	call ArrayFill3
	mov edx, offset out3
	call DispArray
	call Crlf

	exit
main endp

ArrayFill1 proc

	push ebp
	mov ebp, esp

	mov edi, [ebp + 20]
	mov ecx, [ebp + 16]
	L1:

		mov eax, [ebp + 12]
		sub eax, [ebp + 8]
		inc eax
		call RandomRange
		add eax, [ebp + 8]
		mov [edi], eax

		add edi, type dword
		loop L1

	pop ebp
	ret

ArrayFill1 endp

ArrayFill2 proc

	enter 16, 0

	mov edi, [ebp + 20]
	mov ecx, [ebp + 16]
	L1:

		mov eax, [ebp + 12]
		sub eax, [ebp + 8]
		inc eax
		call RandomRange
		add eax, [ebp + 8]
		mov [edi], eax

		add edi, type dword
		loop L1

	leave
	ret

ArrayFill2 endp

ArrayFill3 proc
	LOCAL larrayPtr:PTR DWORD, lcount:DWORD, lupper:DWORD, llower:DWORD

	mov edi, [ebp + 20]
	mov ecx, [ebp + 16]
	L1:

		mov eax, [ebp + 12]
		sub eax, [ebp + 8]
		inc eax
		call RandomRange
		add eax, [ebp + 8]
		mov [edi], eax

		add edi, type dword
		loop L1

	ret

ArrayFill3 endp

DispArray proc

	call WriteString
	call Crlf

	mov ecx, count
	mov edi, offset array
	L1:
		mov eax, [edi]
		call WriteInt
		call Crlf
		add edi, type array
		loop L1

	ret

DispArray endp

end main
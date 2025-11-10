; Perform bitwise operations on 2 numbers

include Irvine32.inc
includelib Irvine32.lib

.data
prompt1 BYTE "Input the first 32-bit hexadecimal operand:  ", 0
prompt2 BYTE "Input the second 32-bit hexadecimal operand: ", 0
result BYTE "The 32-bit hexadecimal result is:            ", 0
info1 BYTE "Boolean AND", 0
info2 BYTE "Boolean OR", 0
info3 BYTE "Boolean NOT", 0
info4 BYTE "Boolean XOR", 0
hexVal1 DWORD ?
hexVal2 DWORD ?

.code

main PROC

	mov edx, offset prompt1
	call WriteString

	call ReadHex
	mov hexVal1, eax

	mov edx, offset prompt2
	call WriteString

	call ReadHex
	mov hexVal2, eax

	call Crlf

	mov edx, offset info1
	call WriteString
	call Crlf
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	and eax, hexVal2
	call WriteHex
	call Crlf

	mov edx, offset info2
	call WriteString
	call Crlf
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	or eax, hexVal2
	call WriteHex
	call Crlf

	mov edx, offset info3
	call WriteString
	call Crlf
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	not eax
	call WriteHex
	call Crlf

	mov edx, offset info4
	call WriteString
	call Crlf
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	xor eax, hexVal2
	call WriteHex
	call Crlf

	exit

main ENDP
end main
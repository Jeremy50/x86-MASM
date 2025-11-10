; Menu selector to perform bitwise operations on 2 numbers

include Irvine32.inc
includelib Irvine32.lib

.data

menu BYTE "<===== Boolean Calculator =====>", 0
menuOpt1 BYTE "  1. x AND y", 0
menuOpt2 BYTE "  2. x OR y", 0
menuOpt3 BYTE "  3. NOT", 0
menuOpt4 BYTE "  4. x XOR y", 0
menuOpt5 BYTE "  5. Exit Program", 0
menuPrompt BYTE "Enter option [1-5]: ", 0
InvalidOption BYTE "INVALID OPTION! Enter num between 1 and 5 only.", 0
choice BYTE ?

CaseTable BYTE 1
          DWORD AND_OP
EntrySize = ( $ - CaseTable)
          BYTE 2
		  DWORD OR_OP
          BYTE 3
		  DWORD NOT_OP
          BYTE 4
		  DWORD XOR_OP
          BYTE 5
		  DWORD EXIT_OP
NumEntries = ( $ - CaseTable) / EntrySize

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

main proc
	call Crlf
	MAINLOOP:
		call DisplayMenu
		call ExecChoice
		call Crlf
		call Crlf
		JMP MAINLOOP
main endp

DisplayMenu proc
	mov edx, offset menu
	call WriteString
	call Crlf
	mov edx, offset menuOpt1
	call WriteString
	call Crlf
	mov edx, offset menuOpt2
	call WriteString
	call Crlf
	mov edx, offset menuOpt3
	call WriteString
	call Crlf
	mov edx, offset menuOpt4
	call WriteString
	call Crlf
	mov edx, offset menuOpt5
	call WriteString
	call Crlf
	mov edx, offset menuPrompt
	call WriteString
	call ReadInt
	mov choice, al
	call Crlf
	ret
DisplayMenu endp

ExecChoice proc
	mov edx, offset CaseTable
	mov ecx, NumEntries
	L1:
		cmp al, [edx]
		jne L2
			call near ptr [edx + 1]
			jmp L3
		L2:
			add edx, EntrySize
			loop L1
	L3:
		cmp ecx, 0
		jnz L4
			mov edx, offset InvalidOption
			call WriteString
		L4: ret
ExecChoice endp

Input1 proc
	mov edx, offset prompt1
	call WriteString
	call ReadHex
	mov hexVal1, eax
	ret
Input1 endp

Input2 proc
	call Input1
	mov edx, offset prompt2
	call WriteString
	call ReadHex
	mov hexVal2, eax
	ret
Input2 endp

AND_OP proc
	mov edx, offset info1
	call WriteString
	call Crlf
	call Input2
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	and eax, hexVal2
	call WriteHex
	call Crlf
	ret
AND_OP endp

OR_OP proc
	mov edx, offset info2
	call WriteString
	call Crlf
	call Input2
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	or eax, hexVal2
	call WriteHex
	call Crlf
	ret
OR_OP endp

NOT_OP proc
	mov edx, offset info3
	call WriteString
	call Crlf
	call Input1
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	not eax
	call WriteHex
	call Crlf
	ret
NOT_OP endp

XOR_OP proc
	mov edx, offset info4
	call WriteString
	call Crlf
	call Input2
	mov edx, offset result
	call WriteString
	mov eax, hexVal1
	xor eax, hexVal2
	call WriteHex
	call Crlf
	ret
XOR_OP endp

EXIT_OP proc
	exit
EXIT_OP endp



end main
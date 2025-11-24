; Find the GCD between two integers

include Irvine32.inc
includelib irvine32.lib

.data
dispA byte "Greatest common divisor of ", 0
dispB byte " and ", 0
dispC byte " is: ", 0

.code
main proc

	push 35
	push 15
	call GCD
	call Disp

	push 72
	push 18
	call GCD
	call Disp

	push 31
	push 17
	call GCD
	call Disp

	push 128
	push 640
	call GCD
	call Disp

	push 121
	push 0
	call GCD
	call Disp

	exit

main endp

GCD proc

    enter 12, 0
    
    mov eax, [ebp + 12]
    mov ebx, [ebp + 8]
    
    cmp eax, ebx
    jae L1
        mov edx, eax
        mov eax, ebx
        mov ebx, edx

	L1:
	cmp ebx, 0
	jne L2
		mov ecx, eax
		jmp L4

	L2:
	push eax
	mov edx, 0
	div ebx
	pop eax
	cmp edx, 0
	jne L3
		mov ecx, ebx
		jmp L4

	L3:
		push ebx
		push edx
		call GCD

	L4:
	leave
	ret 8

GCD endp

Disp proc
	mov edx, offset dispA
	call WriteString
	call WriteDec
	mov edx, offset dispB
	call WriteString
	mov eax, ebx
	call WriteDec
	mov edx, offset dispC
	call WriteString
	mov eax, ecx
	call WriteDec
	call Crlf
	ret
Disp endp

end main
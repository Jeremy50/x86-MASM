; Find factorial of a number by ivoking recursion and loop methods

include irvine32.inc
includelib irvine32.lib

.data
prompt1 byte "The output from the recursive call - ", 0
prompt2 byte "The output from the loop call - ", 0
msgOverflow byte "The factorial value is overflowed", 0
excl byte "!", 0

.code
Factorial proc, n:dword

    jc L2
    mov eax, n

    cmp eax, 1
    ja L1
        mov eax,1
        jmp L2
    L1:
        dec eax
        invoke Factorial, eax

    mov ebx, [ebp+8]
    mul ebx

    L2: ret

Factorial endp

Factorial_loop proc, n:dword

    mov ecx, n
    mov eax, 1

    L1:
        cmp ecx, 0
        jz L2
        mul ecx
        jc L2
    loop L1

    L2: ret

Factorial_loop endp

Run proc, n:dword

    mov edx, offset prompt1
    call WriteString
    mov eax, n
    call WriteDec
    mov edx, offset excl
    call WriteString
    call Crlf

    clc
    invoke Factorial, n
    jnz Overflowed1
        call WriteDec
        jmp E1
    Overflowed1:
        mov edx, offset msgOverflow
        call WriteString
    E1: call Crlf

    mov edx, offset prompt2
    call WriteString
    mov eax, n
    call WriteDec
    mov edx, offset excl
    call WriteString
    call Crlf
    
    clc
    invoke Factorial_loop, n
    jnz Overflowed2
        call WriteDec
        jmp E2
    Overflowed2:
        mov edx, offset msgOverflow
        call WriteString
    E2: call Crlf

    call Crlf
    ret

Run endp


main proc

    invoke Run, 5
    invoke Run, 10
    invoke Run, 15

    exit

main endp

end main
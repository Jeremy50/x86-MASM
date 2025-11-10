; Basic addition with colors

include Irvine32.inc
includelib Irvine32.lib

.data
firstNumMesg BYTE "Enter the first integer: ", 0
secondNumMesg BYTE "Enter the second integer: ", 0
sumMesg BYTE "The sum is: ", 0

.code

prompt PROC uses eax

	call Clrscr
	
	mov dh, 10
	mov dl, 20
	call Gotoxy

	mov edx, offset firstNumMesg
	call WriteString
	
	mov dh, 10
	mov dl, 60
	call Gotoxy

	call ReadInt
	mov ebx, eax
	
	mov dh, 12
	mov dl, 20
	call Gotoxy

	mov edx, offset secondNumMesg
	call WriteString
	
	mov dh, 12
	mov dl, 60
	call Gotoxy
	call ReadInt
	
	mov dh, 14
	mov dl, 20
	call Gotoxy

	mov edx, offset sumMesg
	call WriteString
	add eax, ebx

	mov dh, 14
	mov dl, 60
	call Gotoxy

	call WriteInt
	call Crlf
	call Crlf
	call waitMsg

	ret

prompt ENDP

main PROC

	mov eax, green + black * 16
	mov ecx, 3
	L1:
		call SetTextColor
		add eax, 17
		call prompt
		loop L1

	exit

main ENDP
end main
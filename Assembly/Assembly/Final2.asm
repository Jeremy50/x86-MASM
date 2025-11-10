include Irvine32.inc
includelib Irvine32.lib

.data
msg BYTE "Please enter the message you would like to display: ", 0
buf BYTE 100 Dup(0), 0

.code

main PROC

	mov edx, offset msg
	call WriteString

	mov edx, offset buf
	mov ecx, sizeof buf
	call ReadString
	
	mov ecx, 10
	mov eax, black + white * 16

	L1:

		call SetTextColor
		inc eax

		mov edx, offset buf
		call WriteString
		call Crlf

		loop L1

	call waitMsg
	mov eax, white + black * 16
	call SetTextColor

	exit

main ENDP
end main
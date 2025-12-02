; Display checkboard pattern using PROTO procs

include Irvine32.inc
includelib irvine32.lib

PrintBoard PROTO, color:BYTE
PrintRow   PROTO, color1:BYTE, color2:BYTE
PrintBlock PROTO, char:BYTE,   color:BYTE
DelayProg  PROTO, ms:DWORD

.data
waitMS = 500

.code

main proc

	mov al, 0
	mov ecx, 16
	L1:
		invoke PrintBoard, al
		invoke DelayProg, waitMS
		inc al
		loop L1

	exit

main endp

PrintBoard proc uses eax, color:BYTE
	mov dh, 0
	mov dl, 0
	call Gotoxy
	invoke PrintRow, color, white
	invoke PrintRow, white, color
	invoke PrintRow, color, white
	invoke PrintRow, white, color
	invoke PrintRow, color, white
	invoke PrintRow, white, color
	invoke PrintRow, color, white
	invoke PrintRow, white, color
	mov al, white + black * 16
	invoke SetTextColor
	ret
PrintBoard endp

PrintRow proc, color1:BYTE, color2:BYTE
	invoke PrintBlock, ' ', color1
	invoke PrintBlock, ' ', color2
	invoke PrintBlock, ' ', color1
	invoke PrintBlock, ' ', color2
	invoke PrintBlock, ' ', color1
	invoke PrintBlock, ' ', color2
	invoke PrintBlock, ' ', color1
	invoke PrintBlock, ' ', color2
	invoke Crlf
	ret
PrintRow endp

PrintBlock proc, char:BYTE, color:BYTE
	mov al, color
	shl al, 4
	add al, white
	invoke SetTextColor
	mov al, char
	invoke WriteChar
	invoke WriteChar
	ret
PrintBlock endp

DelayProg proc uses eax ebx, ms:DWORD
	invoke GetTickCount
	mov ebx, eax
	L1:
		invoke GetTickCount
		sub eax, ebx
		cmp eax, ms
		ja L2
		jmp L1
	L2:
	ret
DelayProg endp

end main
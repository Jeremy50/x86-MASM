; Find the first occurence of one string in another

include Irvine32.inc
includelib Irvine32.lib

.data

target byte "01ABAAAAAABABCC45ABC9012", 0
source byte "AAABA", 0

targetMsg byte "The target string is: ", 0
sourceMsg byte "The source string is: ", 0
notFoundMsg byte "Source string not found in Target string.", 0
foundMsg_p1 byte "Source string found at position ", 0
foundMsg_p2 byte " in Target string (counting from zero).", 0

.code

Str_find proto, pTarget: ptr byte, pSource: ptr byte
Str_find_i proto, pTarget: ptr byte, pSource: ptr byte
dispRes proto

main proc

	invoke Str_find, offset target, offset source
	invoke dispRes
	exit

main endp

Str_find proc, pTarget: ptr byte, pSource: ptr byte
	
	mov ecx, lengthof target
	sub ecx, lengthof source
	inc ecx
	mov eax, 0

	mov edx, pTarget
	L1:
		invoke Str_find_i, edx, offset source
		jz Done
		inc edx
		inc eax
		loop L1

	Done:
	ret

Str_find endp

Str_find_i proc uses eax ecx edx, pTarget: ptr byte, pSource: ptr byte
	
	mov esi, pSource
	mov edi, pTarget
	invoke Str_length, pSource
	mov ecx, eax
	
	cld
	repe cmpsb
	ret

Str_find_i endp

dispRes proc uses eax edx

	pushf

	mov edx, offset targetMsg
	invoke WriteString
	mov edx, offset target
	invoke WriteString
	invoke Crlf

	mov edx, offset sourceMsg
	invoke WriteString
	mov edx, offset source
	invoke WriteString
	invoke Crlf

	popf
	jz Found
	NotFound:
		mov edx, offset notFoundMsg
		call WriteString
		jmp Done
	Found:
		mov edx, offset foundMsg_p1
		call WriteString
		call WriteDec
		mov edx, offset foundMsg_p2
		call WriteString

	Done:
		invoke Crlf
		ret

dispRes endp

end main
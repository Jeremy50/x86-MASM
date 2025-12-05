; Compare 2 arrays and search for a word in another

include Irvine32.inc
includelib Irvine32.lib

.data
Sourcew word 10, 20, 30
Targetw word 10, 20, 35
WordArray word 10h, 20h, 30h, 40h
SearchChar word 31h

NotEqualMsg byte "Source Array and Target Array are NOT the same.", 0
EqualMsg byte "Source Array and Target Array are the same.", 0

EdiLocMsg byte "Before searching, EDI is located at: ", 0
SearchCharMsg byte "Searching for the matched word: ", 0

NotFoundMsg byte "No matched word is found.", 0
FoundMsg byte "After searching, the matched word is located at: ", 0


.code

CmpArrs proto
ScaArr proto

main proc

	invoke CmpArrs
	invoke ScaArr

	exit

main endp

CmpArrs proc

	mov esi, offset Sourcew
	mov edi, offset Targetw
	mov ecx, lengthof Sourcew
	cld
	repe cmpsw
	je Equal

	NotEqual:
		mov edx, offset NotEqualMsg
		call WriteString
		call Crlf
		ret
	Equal:
		mov edx, offset EqualMsg
		call WriteString
		call Crlf
		ret

CmpArrs endp

ScaArr proc

	mov ax, SearchChar
	mov edi, offset WordArray
	mov ecx, lengthof WordArray
	
	mov edx, offset EdiLocMsg
	call WriteString
	mov eax, edi
	call WriteHex
	call Crlf

	mov edx, offset SearchCharMsg
	call WriteString
	movzx eax, SearchChar
	call WriteHex
	call Crlf

	cld
	repne scasw
	je Found

	NotFound:
		mov edx, offset NotFoundMsg
		call WriteString
		call Crlf
		ret
	Found:
		mov edx, offset FoundMsg
		call WriteString
		mov eax, edi
		call WriteHex
		call Crlf
		ret

ScaArr endp

end main
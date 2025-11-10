; Encrypt and Decrypt a provided string with a provided key

include Irvine32.inc
includelib Irvine32.lib

BUFMAX = 128

.data
stringPrmpt BYTE "Enter the plain text string: ", 0
keyPrmpt BYTE    "Enter the encryption key:    ", 0
cipherOut BYTE   "Cipher text: ", 0
decryptOut BYTE  "Decrypted:   ", 0
stringBuf BYTE BUFMAX+1 DUP(0)
keyBuf BYTE BUFMAX+1 DUP(0)
stringSize DWORD ?
keySize DWORD ?

.code
main PROC

	mov edx, offset stringPrmpt
	call WriteString

	mov ecx, BUFMAX
	mov edx, offset stringBuf
	call ReadString
	mov stringSize, eax

	mov edx, offset keyPrmpt
	call WriteString

	mov ecx, BUFMAX
	mov edx, offset keyBuf
	call ReadString
	mov keySize, eax
	call Crlf

	mov ecx, stringSize
	mov esi, 0
	mov edi, 0
	L1:
		mov al, byte ptr keyBuf[edi]
		xor stringBuf[esi], al
		inc esi
		inc edi
		cmp edi, keySize
		jne L2
		mov edi, 0
		L2:
		loop L1

	mov edx, offset cipherOut
	call WriteString
	mov edx, offset stringBuf
	call WriteString
	call Crlf

	mov ecx, stringSize
	mov esi, 0
	mov edi, 0
	L3:
		mov al, byte ptr keyBuf[edi]
		xor stringBuf[esi], al
		inc esi
		inc edi
		cmp edi, keySize
		jne L4
		mov edi, 0
		L4:
		loop L3

	mov edx, offset decryptOut
	call WriteString
	mov edx, offset stringBuf
	call WriteString
	call Crlf

	exit

main ENDP
end main
; Move 2BYTE signed and unsigned values into 4BYTE register

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	intA WORD 100
	intB SWORD -100

.code
main proc

	movzx eax, intA
	movsx edx, intB

	invoke ExitProcess, 0

main endp
end main
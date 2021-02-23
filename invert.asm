global  _start

N equ 100
DELTA equ 32

code_a equ 97

section .bss
var_read:	resb N
var_write:	resb N

section .text
_start:
	call asm_read_inverse_string			
				
	call asm_write			
	call asm_exit			

asm_read_inverse_string:					
	call asm_read
        xor rax, rax				
	mov rcx, N					
	l_rd:					
		mov rdx, N
		sub rdx, rcx
		xor rbx, rbx
		mov bl, [var_read + rdx]
		cmp bl, code_a
                jae L1
                add bl, DELTA
                jmp L2
                L1:     sub bl, DELTA
                L2:     mov [var_write + rdx], bl
		loop l_rd
	ret


asm_read:
	mov rax, 0
	mov rdi, 0

	mov rsi, var_read
	mov rdx, N
        syscall
	ret
	
asm_write:
	mov rax, 1
	mov rdi, 1
	mov rsi, var_write
	mov rdx, N
	syscall
	ret

asm_exit:
	mov rax, 60
	xor rdi, rdi
	syscall
	ret

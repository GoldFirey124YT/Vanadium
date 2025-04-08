BITS 16
ORG 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, msg
.print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .print

.done:
    jmp 0x0000:0x7E00

msg db "Loading BSD-like Kernel...", 0

times 510 - ($ - $$) db 0
dw 0xAA55

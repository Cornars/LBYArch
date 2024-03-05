%include "io64.inc"
section .data
var1 db 0
result dq 0
digit_acc dq 0
section .text
global main
decimal_to_radixn:
    JMP start
    error_msg_1:
    PRINT_STRING "This is an invalid radix, radix must not be greater than 16"
    NEWLINE
    JMP start
    error_msg_2:
    PRINT_STRING "This is an invalid radix, radix must not be less than 2"
    JMP start
    
    start:
    NEWLINE

    PRINT_STRING "Enter a decimal number: "

    GET_DEC 4, RAX
    
    PRINT_STRING "Enter a Radix: "
    GET_DEC 4, rsi
    CMP RSI, 16
    JG error_msg_1
    CMP RSI, 2
    JL error_msg_2
    


    PRINT_STRING "Decimal: "
    PRINT_DEC 4, RAX
    cont_div: 
        xor rdx, rdx               
        div rsi            
        
        mov qword [result], rax   
        PUSH RDX
        INC qword [digit_acc]
        
        
        cmp qword [result], 0
        JNE cont_div
    NEWLINE
    PRINT_STRING "N-Radix Result: "
    pop_stack:
        
        POP RBX
        PRINT_HEX 4, RBX
        DEC qword [digit_acc]
        cmp qword [digit_acc], 0
        JNE pop_stack   
     
    
    ret

radixn_to_decimal:
    NEWLINE
    PRINT_STRING "in radixn to decimal"
    
    ret

main:
    PRINT_STRING "[1] Decimal to Radix-n"
    NEWLINE
    PRINT_STRING "[2] Radix-n to Decimal"
    GET_DEC 1, [var1]
    cmp byte [var1], 1
    JE decimal_to_radixn
    cmp byte [var1], 2
    JE radixn_to_decimal
    xor rax, rax
    ret
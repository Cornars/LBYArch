%include "io64.inc"
section .data
var1 db 0

section .text
global main
decimal_to_radixn:
    NEWLINE

    PRINT_STRING "Enter a decimal number: "

    GET_DEC 4, RAX
    
    PRINT_STRING "Enter a Radix: "
    GET_DEC 4, rsi


    PRINT_STRING "Decimal: "
    PRINT_DEC 4, RAX
    
    xor rdx, rdx               
    div rsi             

    
    PRINT_STRING "Hexadecimal Quotient: "
    PRINT_DEC 4, RAX

    ;
    PRINT_STRING "Hexadecimal Remainder: "
    PRINT_DEC 1, DL    

    
 
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
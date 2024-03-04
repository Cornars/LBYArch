%include "io64.inc"
section .data
var1 db 0

section .text
global main
decimal_to_radixn:
    NEWLINE
    PRINT_STRING "in decimal to radix n"
    ret

radixn_to_decimal:
    NEWLINE
    PRINT_STRING "in radixn to decimal"
    PRINT_STRING "test
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
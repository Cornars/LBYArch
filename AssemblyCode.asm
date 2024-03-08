%include "io64.inc"
section .data

;variables for option 1
var1 db 0
result dq 0
digit_acc dq 0


;variables for option2
input1 dq 0
input2 dq 0
accum dq 0
counter dq 0

quotient_buffer dq 0
remainder_buffer dq 0 
current_power dq 1

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

    GET_DEC 8, RAX
    
    PRINT_STRING "Enter a Radix: "
    GET_DEC 8, rsi
    CMP RSI, 16
    JG error_msg_1
    CMP RSI, 2
    JL error_msg_2
    


    PRINT_STRING "Decimal: "
    PRINT_DEC 8, RAX
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
        PRINT_HEX 8, RBX
        DEC qword [digit_acc]
        cmp qword [digit_acc], 0
        JNE pop_stack   
     
    
    ret

radixn_to_decimal:
    PRINT_STRING "N-radix digits: "
    GET_HEX 8, RAX
    NEWLINE
    
    ; Radix, which is in Hex
    PRINT_STRING "Radix: "
    GET_DEC 8, RSI
    NEWLINE

    ; get nth digit, the radix raised it to its position, add it to a sum
    jmp loop_part
    
first_iteration:
    ADD qword [accum], RDX
    INC qword [counter]

loop_part:
    mov r9, 16
    xor rdx, rdx 
    div r9
    CMP RAX, 0
    JE FINIS
    MOV qword [remainder_buffer], RDX
    ; RDX is the digit to raise
    cmp qword [counter], 0
    JE first_iteration
    
    
    mov qword [quotient_buffer], RAX ; RAX had quotient
    mov qword RAX, [current_power]  ;  current power value, so this is 
    mul RSI

    MOV qword [current_power], RAX
    
    MUL qword [remainder_buffer]
    ADD qword [accum], RAX
    
    MOV qword RAX, [quotient_buffer]
    INC qword [counter]
    
   
    JMP loop_part
        


FINIS:
    MOV qword [remainder_buffer], RDX
    ; RDX is the digit to raise
    cmp qword [counter], 0
    JE first_iteration
    
    
    mov qword [quotient_buffer], RAX ; RAX had quotient
    mov qword RAX, [current_power]  ;  current power value, so this is 
    mul RSI

    MOV qword [current_power], RAX
    
    MUL qword [remainder_buffer]
    ADD qword [accum], RAX
    
    
    MOV qword RAX, [quotient_buffer]
    INC qword [counter]
    PRINT_STRING "Decimal equivalent: "
    PRINT_UDEC 8, [accum]
    xor rax, rax
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
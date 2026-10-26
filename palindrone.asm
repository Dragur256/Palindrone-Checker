; Checks if a word is a palindrone or not


            global main:
            extern printf
            
            section .text
main:
            push    r12
            mov     rsi, checkWord              ; Move checkword address to the source string register
            mov     rcx, 0                      ; Zero the counter register
            mov     r13, 0                      ; r13 holds a zero, only for comparison purposes
            
pushStack:                                      ; Begin to push word to the stack
            mov     rax, 0
            mov     al, [checkWord+rcx]         ; Get the current index (rcx)
            push    rax                         ; push character to the stack
            inc     rcx                         ; increment counter
            cmp     rcx, wordLength
            jnz     pushStack
            
            
            mov     rcx, 0                      ; Zero counter before checking
            mov     r12, 1                      ; r12 is a flag for if the word is a palendrone
check:

            mov     rax, 0                      ; Fully zero accumulator
            mov     al, [checkWord+rcx]         ; Get the current index (rcx)
            inc     rcx                         
            pop     rdx                         ; pop character from stack
            cmp     rax, rdx                    ; compare stack value with current index
            cmovne  r12, r13                    ; Set flag to false (0) if not a palendrone
            
            cmp     rcx, wordLength             ; If we are not at the end of the word...
            jne     check                       ; We jump to check again

            cmp     r12, 0                      ; If the word wasn't a palendrone
            je      printNotPalendrone          ; Jump to print

printPalendrone:                                ; If it was, it enters this block
            mov     rdi, palindrone             ; rdi is first parameter (string+format)
            mov     rsi, checkWord              ; rsi is second parameter (word)
            call    printf
            jmp     finish
            
printNotPalendrone:                             ; Exact same as section before, just with a different format
            mov     rdi, notPalindrone
            mov     rsi, checkWord
            call    printf
finish:
            pop     r12                         ; restore stack and return        
            ret
            
            
            
            
            
            
            section .data
notPalindrone:
            dq      "%s is not a palindrone",0,10
palindrone:
            dq      "%s is a palindrone",0,10
checkWord:
            db      "racecar",0
            
            section .bss
wordLength  equ     7
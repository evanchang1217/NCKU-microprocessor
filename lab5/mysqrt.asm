#include "xc.inc"

    GLOBAL _mysqrt  ; Make function globally accessible
    PSECT mytext,local,class=CODE,reloc=2

_mysqrt:
    testValue EQU 0x00A  ; Define a temporary storage register
    result    EQU 0x00B  ; Define result storage register

    MOVLW   0x01         ; Start with 1
    MOVWF   testValue     ; Store 1 in testValue
    MOVFF   0x002, LATD  ; Copy the input (a) to LATD for comparison
    
sqrt_loop:
    MOVLW   0x10
    CPFSEQ  testValue
    GOTO notsixteen
    GOTO sixteen
notsixteen:
    MOVF    testValue, W
    MULWF   testValue    ; Multiply testValue by itself (testValue * testValue)
    MOVF    PRODL, W     ; Get low byte of multiplication result
    
    CPFSGT  LATD         ; Compare with LATD (a), skip if a>testValue^2 
    GOTO    sqrt_done    ; If testValue^2 >= a, we are done

    INCF    testValue, F ; Increment testValue
    GOTO    sqrt_loop    ; Repeat the loop

sqrt_done:
    


    MOVFF    testValue, 0X001 ; Return the final result in WREG
    MOVFF 0X001,WREG
    RETURN
    
sixteen:
    MOVLW   0x10
    MOVWF  0x001
    RETURN
    
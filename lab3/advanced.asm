List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ;PC = 0x00


; ????????
MULTIPLICAND_L   EQU     0x001   
MULTIPLICAND_H   EQU     0x000  
MULTIPLIER_L     EQU     0x011  
MULTIPLIER_H     EQU     0x010  

RESULT_0         EQU     0x023   
RESULT_1         EQU     0x022
RESULT_2         EQU     0x021
RESULT_3         EQU     0x020   ;

; ??????????????????
TEMP1_L          EQU     0x030
TEMP1_H          EQU     0x031
TEMP2_L          EQU     0x032
TEMP2_H          EQU     0x033

; ???????
AL               EQU     0x034   
AH               EQU     0x035   
BL               EQU     0x036  
BH               EQU     0x037   

START:
; ????????
                CLRF    RESULT_0
                CLRF    RESULT_1
                CLRF    RESULT_2
                CLRF    RESULT_3

; ???? 0x12CB ?????????? 0x000 ? 0x001

                MOVLW   0x77
                MOVWF   MULTIPLICAND_H
                MOVLW   0x77
                MOVWF   MULTIPLICAND_L
; ??? 0x0935 ?????????? 0x010 ? 0x011
		MOVLW   0x56
                MOVWF   MULTIPLIER_H
                MOVLW   0x78
                MOVWF   MULTIPLIER_L


; ??????????????
                MOVF    MULTIPLICAND_L, W
                MOVWF   AL
                MOVF    MULTIPLICAND_H, W
                MOVWF   AH

                MOVF    MULTIPLIER_L, W
                MOVWF   BL
                MOVF    MULTIPLIER_H, W
                MOVWF   BH

; ?? AL * BL????? RESULT_0 ? RESULT_1
                MOVF    AL, W
                MULWF   BL              ; WREG * BL
                MOVFF   PRODL, RESULT_0
                MOVFF   PRODH, RESULT_1

; ?? AL * BH????? TEMP1_L ? TEMP1_H
                MOVF    AL, W
                MULWF   BH
                MOVFF   PRODL, TEMP1_L
                MOVFF   PRODH, TEMP1_H

; ?? AH * BL????? TEMP2_L ? TEMP2_H
                MOVF    AH, W
                MULWF   BL
                MOVFF   PRODL, TEMP2_L
                MOVFF   PRODH, TEMP2_H

; ?? AH * BH????? RESULT_2 ? RESULT_3
                MOVF    AH, W
                MULWF   BH
                MOVFF   PRODL, RESULT_2
                MOVFF   PRODH, RESULT_3

; ? TEMP1 ? TEMP2 ?????? RESULT ?

; ?? TEMP1_L ? RESULT_1
                MOVF    TEMP1_L, W
                ADDWF   RESULT_1, F
                BTFSC   STATUS, C       ; ?????
                INCF    RESULT_2, F     ; ??? RESULT_2

; ?? TEMP1_H ? RESULT_2
                MOVF    TEMP1_H, W
                ADDWF   RESULT_2, F
                BTFSC   STATUS, C       ; ?????
                INCF    RESULT_3, F     ; ??? RESULT_3

; ?? TEMP2_L ? RESULT_1
                MOVF    TEMP2_L, W
                ADDWF   RESULT_1, F
                BTFSC   STATUS, C       ; ?????
                INCF    RESULT_2, F     ; ??? RESULT_2

; ?? TEMP2_H ? RESULT_2
                MOVF    TEMP2_H, W
                ADDWF   RESULT_2, F
                BTFSC   STATUS, C       ; ?????
                INCF    RESULT_3, F     ; ??? RESULT_3

; ????
                END
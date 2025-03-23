    List p=18f4520
    #include <p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ; PC = 0x00

NUM_VALUE EQU 0x008
n_value   EQU 0x009
FIBH      EQU 0x000  ; ????
FIBL      EQU 0x001  ; ????
FIB1H     EQU 0x002  ; ?????
FIB1L     EQU 0x003  ; ?????
FIB2H     EQU 0x004  ; ??????
FIB2L     EQU 0x005  ; ??????

initial:
    MOVLW 0x0F
    MOVWF NUM_VALUE
    MOVFF NUM_VALUE, n_value
    
    MOVLW 0x00    
    MOVWF FIB2H
    MOVLW 0x00
    MOVWF FIB2L

    MOVLW 0x00    
    MOVWF FIB1H
    MOVLW 0x01
    MOVWF FIB1L

    MOVLW 0x00
    MOVWF FIBH
    MOVLW 0x00
    MOVWF FIBL

    rcall fib
    goto finish

fib:
if0:
    MOVLW 0x00
    CPFSEQ NUM_VALUE
        GOTO if1
    GOTO Stop

if1:
    MOVLW 0x01
    CPFSEQ NUM_VALUE
        GOTO LOOP
    MOVLW 0x01
    MOVWF FIBL
    GOTO Stop

LOOP:
    DECFSZ n_value
        GOTO Start
    GOTO Stop

Start:
    MOVF FIB1L, W
    ADDWF FIB2L, W     ; W = FIB1L + FIB2L
    MOVWF FIBL         ; ????FIBL

    ; Check for carry from lower byte addition and add higher bytes
    MOVF FIB1H, W
    BTFSC STATUS, C       ; Check if carry bit is set
    ADDLW 0x01            ; Add 1 to W if carry occurred
    ADDWF FIB2H, W        ; W = FIB1H + FIB2H (+ 1 if carry)
    MOVWF FIBH            ; Store the result in FIBH
    BCF STATUS, C  

    MOVFF FIB1H, FIB2H ; ??FIB2?????
    MOVFF FIB1L, FIB2L
    MOVFF FIBH, FIB1H  ; ??FIB1????
    MOVFF FIBL, FIB1L
    GOTO LOOP

Stop:
    RETURN

finish:
    end
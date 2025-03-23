List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ;PC = 0x00
    
    
MOVLW 0xFF
MOVWF 0x000

MOVLW 0xF1
MOVWF 0x001

MOVLW 0x00
MOVWF 0x002
    
MOVLW 0x09
MOVWF 0x004
Loop:
    DECFSZ 0x004
        GOTO Start
    GOTO Next
    
Start:
    BTFSC 0x000,7 ;SKIP IF BIT=0
	GOTO Isone
    RLNCF 0x000
    GOTO Loop
Isone:
    MOVFF 0x004,0x002
    DECF 0x002
    MOVLW 0x08
    ADDWF 0x002
    RLNCF 0x000
    DECFSZ 0x000 ;0X000-1 SKIP IF =0
	INCF 0x002
    TSTFSZ 0x000 ;skip if=0
	Goto Stop 
    TSTFSZ 0x001 ;skip if=0
	INCF 0x002
    Goto Stop 
Next:
MOVLW 0x09
MOVWF 0x004
Loop2:    
    DECFSZ 0x004
        GOTO Start2
    GOTO Stop 
Start2:
    BTFSC 0x001,7 ;SKIP IF BIT=0
	GOTO Isone2
    RLNCF 0x001
    GOTO Loop2
Isone2:
    MOVFF 0x004,0x002
    DECF 0x002
    RLNCF 0x001
    DECFSZ 0x001 ;0X000-1 SKIP IF =0
	INCF 0x002
	
    GOTO Stop    
    
    
Stop:

    
end
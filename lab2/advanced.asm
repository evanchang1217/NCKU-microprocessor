List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

; 0x08, 0x7C, 0x78, 0xFE, 0x34, 0x7A, and 0x0D    
MOVLB 0x01
MOVLW 0x00       
MOVWF 0x100 

MOVLW 0x01       
MOVWF 0x101

MOVLW 0x02       
MOVWF 0x102

MOVLW 0x03       
MOVWF 0x103

MOVLW 0x4     
MOVWF 0x104

MOVLW 0x5    
MOVWF 0x105
    
MOVLW 0x6     
MOVWF 0x106
    
LFSR 0, 0x100
    
MOVLW b'00000111' 
MOVLB 0x00  
MOVWF 0x004  
 
Loop1:
    DECFSZ 0x004
        GOTO Start1
    GOTO Stop

    
Start1: 
    LFSR 0, 0x100
    MOVLW b'00000111'  
    MOVWF 0x003
    
    Loop2:
        DECFSZ 0x003
	    GOTO Start2
	GOTO Loop1
    Start2:
    MOVF POSTINC0,W
    CPFSGT INDF0
	GOTO Smaller
	GOTO Loop2
    Smaller:
    MOVFF INDF0,0x002
    MOVWF POSTDEC0
    MOVFF 0x002 , POSTINC0
    
    
    GOTO Loop2
Stop:

    
END
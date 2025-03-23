List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
MOVLB 0x01      ; ?? BSR ???? 1????? 1     
CLRF 0x100
CLRF 0x101
CLRF 0x102
CLRF 0x103
CLRF 0x104
CLRF 0x105
CLRF 0x106
CLRF 0x110
CLRF 0x111
CLRF 0x112
CLRF 0x113
CLRF 0x114
CLRF 0x115
CLRF 0x116
    
    
    
    
    
MOVLW 0x01  
  
MOVWF 0x100 

MOVLW 0x00      ; ??? 0x01???????????Bank 1?
MOVWF 0x116      ; ???????? 1 ??? 0x16?????? 0x116
 
LFSR 0, 0x100
LFSR 1, 0x116
LFSR 2, 0x101

MOVLW b'00000111' 
MOVLB 0x00  
MOVWF 0x004  
 
Loop:
    DECFSZ 0x004
        GOTO Start
    GOTO Stop
    
Start:
    MOVF INDF1,W
    ADDWF INDF2
    MOVF POSTINC0,W
    ADDWF POSTINC2
    
    MOVF POSTDEC1,W
    ADDWF INDF1
    MOVF INDF0,W
    ADDWF INDF1
    
    
    GOTO Loop
Stop:



    
end    

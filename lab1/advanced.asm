List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

    
   
MOVLW 0XF7        
MOVWF 0x000   
    
BCF STATUS, C          ; Ensure carry bit is clear
RRCF 0x000, F           ; First logical right shift
    
BCF STATUS, C          ; Clear carry bit
RRCF 0x000, F           ; Second logical right shift

BCF STATUS, C          ; Clear carry bit
RRCF 0x000, F           ; Third logical right shift

BCF STATUS, C          ; Clear carry bit
RRCF 0x000, F           ; Fourth logical right shift
RLNCF 0x000
RLNCF 0x000    
RLNCF 0x000
RLNCF 0x000
    
    
MOVLW 0X9F
MOVWF 0x001 
BCF STATUS, C          ; Ensure carry bit is clear
RLCF 0x001, F           ; First logical LEFT shift
    
BCF STATUS, C          ; Clear carry bit
RLCF 0x001, F           ; Second logical LEFT shift

BCF STATUS, C          ; Clear carry bit
RLCF 0x001, F           ; Third logical LEFT shift

BCF STATUS, C          ; Clear carry bit
RLCF 0x001, F           ; Fourth logical LEFT shift
RRNCF 0x001
RRNCF 0x001    
RRNCF 0x001
RRNCF 0x001  
    
MOVF  0x000, W       
ADDWF 0x001, W       

MOVWF 0x002 
    
MOVLW b'00000000' 
MOVWF 0x003   
MOVLW b'00001001' 
MOVWF 0x004     
Loop:
    DECFSZ 0x004
        GOTO Start
    GOTO Stop
Start:
    RRNCF 0x002        
    BTFSC 0x002, 0     ; ???0????0(???????????????)????
	GOTO Loop
	
    INCF 0x003
    GOTO Loop
Stop:
    
end



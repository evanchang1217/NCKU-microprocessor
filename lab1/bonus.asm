List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

    
    
MOVLW 0XCC        
MOVWF 0x000 
MOVWF 0x011     

MOVLW 0X01
MOVWF 0x010
    
MOVLW b'00001001' 
MOVWF 0x004     
Loop:
    DECFSZ 0x004
        GOTO Start
    GOTO Stop
    
Start:
    BTFSC 0x000, 0     ; ???0????0(???????????????)????
	GOTO Nottwo
    
    BTFSC 0x000, 1     ; ???0????0(???????????????)????
	GOTO Notfourbuttwo
    INCF 0x010
    INCF 0x010
    GOTO Rotate
    
Notfourbuttwo:	
    INCF 0x010
    GOTO Rotate
Nottwo:
    DECF 0x010
Rotate:    
    RRNCF 0x000 
    MOVF  0x011, W 
    CPFSEQ 0x000 
	GOTO Loop
    GOTO Stop
   
Stop:
    
end


List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
;0x28, 0x34, 0x7A, 0x80, 0xA7, 0xD1, and 0xFE   
    
MOVLW 0x00      
MOVWF 0x000 
LFSR 0, 0x000
    
MOVLW 0x11     
MOVWF 0x001

MOVLW 0x22      
MOVWF 0x002
    
MOVLW 0x33      
MOVWF 0x003
    
MOVLW 0x44      
MOVWF 0x004 
    
MOVLW 0x55      
MOVWF 0x005 
    
MOVLW 0x66     
MOVWF 0x006
LFSR 1, 0x006
    
MOVLW 0x00     
MOVWF 0x011    
    
MOVLW 0x34
MOVWF 0x007  ;req

MOVLW 0x00     
MOVWF 0x020  ;l

    
MOVLW 0x06 
MOVWF 0x021  ;r

MOVLW 0x04 
MOVWF 0x030  ;r    

    
Loop:
    DECFSZ 0x030
	GOTO Start
    GOTO Stop
    
Start:
    MOVLW 0x00 
    MOVWF 0x023 ;mid
    
    MOVF 0x021,W
    ADDWF 0x023
    ;DECF  0x023
    MOVF 0x020,W
    ADDWF 0x023 
    BCF STATUS, C          ; Clear carry bit
    RRCF 0x023 
   
    
    
    ;mid = (l+r)/2
    
    MOVF 0x023,W
    LFSR 0, 0x000
    
    MOVFF PLUSW0,0X40;arr[mid]
    
    MOVFF 0X40,WREG
    CPFSEQ 0x007
	GOTO Notequal
    GOTO Equal
    
    
    Equal:
	MOVLW 0xFF     
	MOVWF 0x011
	GOTO Stop
    Notequal:
	MOVF 0x007 ,W
	CPFSGT 0x40
	    GOTO Notgreater
	GOTO Greater
    Notgreater:
	INCF 0x023
	MOVF 0x023,W ;wreg = mid+1
	MOVWF 0x020 ;l = mid+1
	GOTO Loop
    
    
    Greater:
	DECF 0x023
	MOVF 0x023,W ;wreg = mid-1
	MOVWF 0x021 ;r=mid-1
	GOTO Loop
    
Stop:



    
end   
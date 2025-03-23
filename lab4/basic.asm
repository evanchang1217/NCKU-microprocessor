List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ;PC = 0x00
    
    
Sub_Mul  macro xh, xl, yh, yl 
    MOVF yl,W
    SUBWF xl
    MOVFF xl,0X001
    
  
    MOVF yh,W
    SUBWFB xh
    MOVFF xh,0X000
    GOTO MUL
    	
    MUL:
        MOVF    0X000, W
	MULWF   0X001              ; WREG * BL
	MOVFF   PRODL, RESULT_0 
	MOVFF   PRODH, RESULT_1
	
    
    endm

    
xh  EQU     0x00A   
xl  EQU     0x00B  
yh  EQU     0x00C  
yl  EQU     0x00D 
RESULT_0         EQU     0x011  
RESULT_1         EQU     0X010
     
MOVLW   0x03
MOVWF   xh
MOVLW   0xA5
MOVWF   xl

MOVLW   0x02
MOVWF   yh
MOVLW   0xA7
MOVWF   yl
Sub_Mul xh, xl, yh, yl 

END
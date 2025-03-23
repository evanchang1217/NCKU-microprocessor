List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ;PC = 0x00


a1  EQU     0x000   
a2  EQU     0x001 
a3  EQU     0x002  
b1  EQU     0x003 
b2  EQU     0x004  
b3  EQU     0x005 
c1  EQU     0x020   
c2  EQU     0x021 
c3  EQU     0x022
  
temp1 EQU   0x006
temp2 EQU   0x007

initial:
    
    MOVLW   0x03
    MOVWF   a1
    MOVLW   0x04
    MOVWF   a2
    MOVLW   0x07
    MOVWF   a3
    MOVLW   0x05
    MOVWF   b1
    MOVLW   0x05
    MOVWF   b2
    MOVLW   0x03
    MOVWF   b3
    
    rcall cross
    goto finish
    
cross:
    
    MOVF a2,W
    MULWF b3
    MOVFF   PRODL, temp1 
    
    MOVF a3,W
    MULWF b2
    MOVFF   PRODL, temp2 
    
    MOVF temp2,W
    SUBWF temp1
    MOVFF temp1,c1
    
    
    
    MOVF a3,W
    MULWF b1
    MOVFF   PRODL, temp1 
    
    MOVF a1,W
    MULWF b3
    MOVFF   PRODL, temp2 
    
    MOVF temp2,W
    SUBWF temp1
    MOVFF temp1,c2
    
    
    MOVF a1,W
    MULWF b2
    MOVFF   PRODL, temp1 
    
    MOVF a2,W
    MULWF b1
    MOVFF   PRODL, temp2 
    
    MOVF temp2,W
    SUBWF temp1
    MOVFF temp1,c3
    RETURN
    


finish:
    end
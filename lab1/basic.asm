List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

MOVLW 0x1F         
MOVWF 0x000            
  
MOVLW 0x01          
MOVWF 0x001            

MOVF  0x000, W       
ADDWF 0x001, W       

MOVWF 0x002          

    
MOVLW 0x7F         
MOVWF 0x010          

MOVLW 0x6F         
MOVWF 0x011           


MOVF  0x011, W        
SUBWF 0x010, W        

MOVWF 0x012  

    
    
MOVF    0x002, W    
    

CPFSEQ  0x012         
    GOTO    NOTEQUAL      
    
EQUAL:
    MOVLW   0xBB          ; A1 = A2, ?? WREG ? 0xBB
    GOTO    STORE_RESULT  ; ??????  


NOTEQUAL:    
    MOVF    0x012, W    
    CPFSGT  0x002
	GOTO    LESS
	
	
GREATER:
    MOVLW   0xAA      
    GOTO    STORE_RESULT  
    
    
LESS:
    MOVLW   0xCC    
    GOTO    STORE_RESULT  

STORE_RESULT:
    MOVWF   0x020         ; ???????? 0x020
    
end

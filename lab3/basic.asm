List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ;PC = 0x00
    CLRF TRISA
    MOVLW 0xC8
    MOVWF TRISA	;Address F92
    RLNCF TRISA	;left shift
    BCF TRISA,0		;set LSB 0
    BTFSC TRISA,7      ;msb=0 skip
	GOTO negative	
    RRNCF TRISA
    BCF TRISA,7		;set MSB 0
    GOTO exit
    negative:
	RRNCF TRISA
	BSF TRISA,7	;set MSB 1
    exit:
    end
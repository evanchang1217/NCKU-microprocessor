#include "xc.inc"

GLOBAL _gcd    ; Make function gobally accessible
PSECT mytext,local,class=CODE,reloc=2

_gcd:
    

    ah EQU 0x00A
    al EQU 0x00B
    bh EQU 0x00C
    bl EQU 0x00D
    th EQU 0x00E
    tl EQU 0x00F

    ;compare a,b
    MOVFF   0x001, al  
    MOVFF   0x002, ah  

    MOVFF   0x003, bl    
    MOVFF   0x004, bh  
    
    MOVF bh,W
    CPFSLT ah ;skip if a<b
    GOTO ifequal
    GOTO swap
    
    ifequal:
    MOVF bh,w
    CPFSEQ ah;skip if a=b
    GOTO loop
    MOVF bl,W
    CPFSLT al ;skip if al<bl
    GOTO loop
    GOTO swap
    
    
    swap:
    MOVFF ah,th;
    MOVFF al,tl;
    MOVFF bh,ah;
    MOVFF bl,al;
    MOVFF th,bh;
    MOVFF tl,bl;
    
    loop:
    TSTFSZ bh ;skip if=0
    GOTO div
    TSTFSZ bl
    GOTO div
    GOTO iszero
    

    div:
	MOVF ah,W
	MOVWF th
	MOVF al,W
	MOVWF tl
	divloop:
	MOVF bh,W
	CPFSLT th ;skip if ah<bh
	GOTO ifeq
	GOTO smaller
	ifeq:
	CPFSEQ th;skip if ah=bh
	GOTO sub
	MOVF bl,W
	CPFSLT tl ;skip if al<bl
	GOTO sub
	GOTO smaller
	sub:
	MOVF bl,W
	SUBWF tl
	MOVF bh,W
	SUBWFB th
	GOTO divloop
	smaller:
	MOVFF bh,ah
	MOVFF bl,al
	MOVFF th,bh
	MOVFF tl,bl
	GOTO loop
	
	
    iszero:
    MOVFF al,0x001
    MOVFF ah,0x002
    RETURN
    
    
   
#include "p18f4520.inc"

; CONFIG1H
  CONFIG  OSC = INTIO67         ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 3              ; Brown Out Reset Voltage bits (Minimum setting)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = PORTC        ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = ON           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) not protected from table reads executed in other blocks)
  
L1 EQU 0x14
L2 EQU 0x15
STATE EQU 0x00
COUNTERMAX EQU 0x01
COUNTER EQU 0x02
TEMP EQU 0x03
org 0x00
    
DELAY macro num1, num2 
    local LOOP1 
    local LOOP2
    MOVLW num2
    MOVWF L2
    LOOP2:
	MOVLW num1
	MOVWF L1
    LOOP1:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DECFSZ L1, 1
	BRA LOOP1
	DECFSZ L2, 1
	BRA LOOP2
endm

goto Initial			    
ISR:				
    ; change state
    org 0x08
    DELAY d'111', d'70'
    INCF STATE
    MOVLW 0x03
    CPFSGT STATE
    GOTO next
    CLRF STATE
    INCF STATE
    next:
    ; change countermax
    MOVLW 0x01
    CPFSEQ STATE 
    GOTO s1
    MOVLW 0x03
    MOVWF COUNTERMAX
    GOTO getcountermax
    s1:
    MOVLW 0x02
    CPFSEQ STATE 
    GOTO s2
    MOVLW 0x07
    MOVWF COUNTERMAX
    GOTO getcountermax
    s2:
    MOVLW 0x03
    CPFSEQ STATE 
    NOP
    MOVLW 0x0F
    MOVWF COUNTERMAX
    GOTO getcountermax
    getcountermax:
    CLRF COUNTER
    BCF INTCON, INT0IF ; call ISR will set this to 1, need to clear it for preventing active ISR again
    RETFIE
    
Initial:			
    ;configuration
    MOVLW 0x0F
    MOVWF ADCON1 ; digital mode
    CLRF TRISA ; port A
    CLRF LATA 
    BSF TRISB, 0 ; port B
    BCF RCON, IPEN ; disable priority levels on interrupts
    BSF INTCON, GIE ; enable all high-priority interrupts
    BSF INTCON, INT0IE ; enable bit(allow interrupt)
    BCF INTCON, INT0IF ; flag bit(interrupt open)
    ;varieble
    CLRF STATE ;STATE = 0
    CLRF COUNTER
    CLRF COUNTERMAX
    CLRF TEMP
main:		
    CALL display
    BRA main	    

display:
    MOVFF COUNTERMAX,WREG
    CPFSGT COUNTER
    GOTO lightup
    CLRF LATA
    RETURN ; counter>countermax
    lightup:
    MOVFF COUNTER, WREG
    RRCF WREG
    RLCF TEMP
    RRCF WREG
    RLCF TEMP
    RRCF WREG
    RLCF TEMP
    RRCF WREG
    RLCF TEMP
    MOVFF TEMP , LATA
    DELAY d'150', d'100'
    INCF COUNTER
    RETURN
end


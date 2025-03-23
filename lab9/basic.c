#include <xc.h>
#include <pic18f4520.h>
#include <stdio.h>
#define _XTAL_FREQ 1000000
#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON    // Brown-out Reset Enable bit
#pragma config PBADEN = OFF  // Watchdog Timer Enable bit
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF     // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)
const int ID[] = {1,2,3,4,5,6,7,8};
void __interrupt(high_priority)H_ISR(){
    
    //step4
    int value = (ADRESH << 8) + ADRESL;
    
    
    //do things
    LATB = ID[value / 128]; // (2^10 / 8) = 128
    
    //clear flag bit
    PIR1bits.ADIF = 0;
    
    
    //step5 & go back step3
    // step5 & go back step3
    __delay_ms(5);  // delay at least 2tad
    ADCON0bits.GO = 1;
    
    return;
}

void main(void) 
{
    //configure OSC and port
    OSCCONbits.IRCF = 0b100; //1MHz
    TRISAbits.RA0 = 1;       //analog input port
    
    
        // Set RC0, RC1, RC2, RC3 as digital output for the LEDs
    TRISB = 0;  // Set PORTbas output
    LATB = 0;   // Clear PORTb data latch
    
    ADCON1bits.VCFG0 = 0;
    ADCON1bits.VCFG1 = 0; 
    //step1
    ADCON1bits.PCFG = 0b1110//AN0 analog input,others digital
    ADCON0bits.CHS = 0b0000;  //AN0 analog input
    
    ADCON2bits.ADCS = 0b000;  //data sheet 000(1Mhz < 2.86Mhz)
    ADCON2bits.ACQT = 0b001;  //Tad = 2 us acquisition time 2Tad = 4 > 2.4
    ADCON0bits.ADON = 1;
    ADCON2bits.ADFM = 1;    //right justified 
    
    
    
    //step2
    PIE1bits.ADIE = 1;
    PIR1bits.ADIF = 0;
    INTCONbits.PEIE = 1;
    INTCONbits.GIE = 1;


    //step3
    ADCON0bits.GO = 1;
    
    while(1);
    
    return;
}
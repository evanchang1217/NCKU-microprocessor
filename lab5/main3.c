#include <xc.h>

// Declare the assembly function to be called from C
extern unsigned int multi_signed(unsigned char a,unsigned char b);

int main() {

    volatile unsigned int result = multi_signed(100,0 );  // Call assembly function
    while(1);
    return 0;
}


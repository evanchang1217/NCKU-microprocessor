#include <xc.h>

// Declare the assembly function to be called from C
extern unsigned char mysqrt(unsigned char a);

int main() {
    volatile unsigned char a=144;
    volatile unsigned char result = mysqrt(a);  // Call assembly function
    while(1);
    return 0;
}

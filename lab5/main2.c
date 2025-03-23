#include <xc.h>

// Declare the assembly function to be called from C
extern unsigned int gcd(unsigned int a,unsigned int b);

int main() {

    volatile unsigned int result = gcd(33333,22222);  // Call assembly function
    while(1);
    return 0;
}

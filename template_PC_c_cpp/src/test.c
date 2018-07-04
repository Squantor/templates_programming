#include <stdint.h>
#include <stdio.h>
#include <test.h>

int testfunc(void)
{
    printf("Test function from %s %d\n", __FILE__, __LINE__);
    return 0;
}
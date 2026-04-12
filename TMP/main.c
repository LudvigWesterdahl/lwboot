#include <stdio.h>

int main(int argc, char **argv)
{
    char *myname="Ludvig\n\0";
    printf(myname);
    return 0;
}

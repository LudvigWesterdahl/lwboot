#include <stdio.h>

int main(int argc, char **argv)
{
    char *myname="Ludvig\n\0";
    printf(myname);

    printf("The value of argc is %d\n", argc);

    int i;
    for (i = 0; i < argc; i++) {
        printf("arg %d is %s\n", i, argv[i]);
    }

    return 0;
}

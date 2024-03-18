#include <iso646.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    int Mb = 0;
    while (malloc(1 << 20)) Mb++;
    printf("%d\n", Mb);
    if (1 and 2) {
        printf("3");
    } else {
        printf("no");
    }
}

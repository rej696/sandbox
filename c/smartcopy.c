#include <string.h>
int main(void) {
    char src[65536], dst[65536];
    for (int j = 0; j < 100; j++) {
        memcpy(dst, src, 65536);
    }
}

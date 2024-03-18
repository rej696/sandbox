#include <string.h>
int main(void) {
    char src[65536], dst[65536];
    for (int j = 0; j < 100; j++) {
        for (int i = 0; i < 65536; i++) {
            dst[i] = src[i];
        }
    }
}

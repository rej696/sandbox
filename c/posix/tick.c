//usr/bin/gcc "$0" -o "$0.out" && exec "./$0.out" "$@"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define FIFO_NAME "tasty_fifo"

int main(void)
{
    char str[300] = {0};
    int num = 0;
    int fd = 0;

    int res = mkfifo(FIFO_NAME, 0644); /* set permissions on FIFO */

    if (res == -1) {
        if (errno != EEXIST) {
            printf("%d\n", errno);
            perror("mkfifo");
            exit(1);
        }
    }

    printf("waiting for writers...\n");
    fd = open(FIFO_NAME, O_RDONLY);
    printf("got a writer\n");

    do {
        if ((num = read(fd, str, sizeof(str))) == -1) {
            perror("read");
        } else {
            str[num] = '\0';
            printf("tick: read %d bytes: \"%s\"\n", num, str);
        }
    } while (num > 0);

    return 0;
}

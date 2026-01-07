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
        perror("mkfifo");
        exit(1);
    }

    printf("waiting for readers...\n");
    fd = open(FIFO_NAME, O_WRONLY);
    printf("got a reader--type some stuff\n");

    while (fgets(str, sizeof(str), stdin) != NULL || !feof(stdin)) {
        if ((num = write(fd, str, strlen(str))) == -1) {
            perror("write");
        } else {
            printf("speak: wrote %d bytes\n", num);
        }
    }
    return 0;
}

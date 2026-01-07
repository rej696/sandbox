//usr/bin/gcc "$0" && exec ./a.out "$@"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void)
{
    /* pipe file descriptors (pfds[0] is read end, pdfs[1] is write end) */
    int pfds[2] = {0};
    char buf[30] = {0};

    if (pipe(pfds) == -1) {
        perror("pipe");
        exit(1);
    }

    int pid = fork();
    if (pid == -1) {
        perror("fork");
        exit(1);
    }
    if (pid == 0) {
        printf(" CHILD: writing to pipe (fd: #%d)\n", pfds[1]);
        write(pfds[1], "test", 5);
        printf(" CHILD: exiting\n");
    } else {
        printf("PARENT: reading from pipe (fd: #%d)\n", pfds[0]);
        read(pfds[0], buf, 5);
        printf("PARENT: read \"%s\"\n", buf);
        wait(NULL);
    }

    return 0;
}

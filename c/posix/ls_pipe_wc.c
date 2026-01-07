//usr/bin/gcc "$0" && exec ./a.out "$@"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void)
{
    int pfds[2] = {0};

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
        close(fileno(stdout)); /* close stdout (find fd of stdout FILE* */
        dup(pfds[1]); /* dup makes a copy of the write pipe fd to the first available fd (stdout now we have closed it) */
        close(pfds[0]); /* don't need the read end of the pipe here */
        execlp("ls", "ls", NULL);
    } else {
        close(fileno(stdin)); /* close stdin (find fd of stdin FILE* */
        dup(pfds[0]); /* dup makes a copy of the read pipe fd to the first available fd (stdin now we have closed it) */
        close(pfds[1]); /* don't need the write end of the pipe here */
        execlp("wc", "wc", "-l", NULL);
    }

    return 0;
}

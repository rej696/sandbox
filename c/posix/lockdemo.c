//usr/bin/gcc "$0" -o "$0.out" && exec "./$0.out" "$@"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    /* man 2 fcntl grep for flock */
    struct flock fl = {
        .l_type = F_WRLCK,
        .l_whence = SEEK_SET,
        .l_start = 0,
        .l_len = 0,
    };

    if (argc > 1) {
        fl.l_type = F_RDLCK;
    }

    int fd = open("README.md", O_WRONLY); /* get the fd */
    if (fd == -1) {
        perror("open");
        exit(1);
    }

    printf("Press <RETURN> to try to get the lock: ");
    getchar();
    printf("Trying to get lock...");

    /* lock, blocking if needed (the W indicates Wait) */
    int res = fcntl(fd, F_SETLKW, &fl); /* F_GETLK, F_SETLK, F_SETLKW */
    if (res == -1) {
        perror("fnctl");
        exit(1);
    }

    printf("got lock\n");
    printf("Press <RETURN> to release lock: ");
    getchar();

    /* then unlock */
    fl.l_type = F_UNLCK;
    res = fcntl(fd, F_SETLK, &fl);
    if (res == -1) {
        perror("fcntl");
        exit(1);
    }

    printf("Unlocked.\n");

    close(fd);

    return 0;
}

//usr/bin/gcc "$0" && exec ./a.out "$@"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>

void sigint_handler(int sig)
{
    char const msg[] = "SIGINT!\n";
    write(0, msg, sizeof(msg));
}

int main(void)
{
    char str[200];
    struct sigaction sa = {
        .sa_handler = sigint_handler,
        .sa_flags = SA_RESTART, /* restart if sigint received */
        .sa_mask = 0,
    };

    int res = sigaction(SIGINT, &sa, NULL);
    if (res == -1) {
        perror("sigaction");
        exit(1);
    }

    printf("Enter a string:\n");
    if (fgets(str, sizeof(str), stdin) == NULL) {
        perror("fgets");
    } else {
        printf("You entered: %s\n", str);
    }
    return 0;
}


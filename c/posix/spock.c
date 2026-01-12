//usr/bin/gcc "$0" -o "$0.out" && exec "./$0.out" "$@"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>

typedef struct {
    long mtype;
    char mtext[200];
} msgbuf_t;


int main(void)
{
    msgbuf_t buf;
    int msgqid;
    key_t key;

    /* Use same key as kirk.c to connect to its queue */
    if ((key = ftok("kirk.c", 'B')) == -1) {
        perror("ftok");
        exit(1);
    }

    /* get the kirk message queue using the key */
    if ((msgqid = msgget(key, 0644)) == -1) {
        perror("msgget");
        exit(1);
    }

    printf("Spock here: ready to receive messages, captain.\n");

    for (;;) {
        if (msgrcv(msgqid, &buf, sizeof(buf.mtext), 0, 0) == -1) {
            perror("msgrcv");
            exit(1);
        }
        printf("spock: \"%s\"\n", buf.mtext);
    }

    return 0;
}

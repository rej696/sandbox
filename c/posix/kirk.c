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

#if 0
/* msgbuf_t can have anything in its second field, including a struct
 * as long as the first field is a long called mtype e.g. */
struct {
    long mtype;
    struct {
        int embedded_val;
        char text[200];
    } data;
} msgbuf_t;
#endif


int main(void)
{
    msgbuf_t buf;
    int msgqid;
    key_t key;

    /* Key is generated from some unique path and an arbitrary char to keep it unique */
    if ((key = ftok("kirk.c", 'B')) == -1) {
        perror("ftok");
        exit(1);
    }

    /* create/get a message queue using the key */
    if ((msgqid = msgget(key, 0644 | IPC_CREAT)) == -1) {
        perror("msgget");
        exit(1);
    }

    printf("Enter lines of text, ^D to quit:\n");

    buf.mtype = 1; /* value is used to allow reader to specify which type of message to read */

    while (fgets(buf.mtext, sizeof(buf.mtext), stdin) != NULL) {
        int len = strlen(buf.mtext);

        /* remove newline */
        if ((len >= 1) && (buf.mtext[len - 1] == '\n')) {
            buf.mtext[len - 1] = '\0';
        }

        if (msgsnd(msgqid, &buf, len, 0) == -1) {
            perror("msgsnd");
        }
    }

    /* Close message queue */
    if (msgctl(msgqid, IPC_RMID, NULL) == -1) {
        perror("msgctl");
        exit(1);
    }

    return 0;
}

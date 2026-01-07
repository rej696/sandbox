# Posix/Unix/Syscalls/IPC etc.

Code files, notes and examples from reading through [Beejs guide to Interprocess communication](https://beej.us/guide/bgipc/html/)

## Tips
- Can send a signal to a running process with `kill -<SIGNAL> <pid>`, e.g. `kill -USR1 1234` sends the USR1 signal to pid 1234.
    - the signal will be handled by the running thread in the process
    - Can use pthread_kill to specify a thread in the process to handle the signal

- `man 7 signal` gives overview of signals
- `sigaction` should be used instead of `signal` (`man 2 sigaction`)


## Manpages Tips
- `man man` explains the man pages sections.
    - man 2 is system calls (functions provided by the kernel)
    - man 7 is overview/descriptions
    - `apropos <pat>` can search for manpages including <pat> text
    - `apropos . -s 7` will list all man pages in section 7

### Man page reading order:
Overview:
- man 7 man-pages
- man 7 unix
- man 7 posixoptions
- man 7 environ
- Project: print argv + all environment variables with getenv/setenv/unsetenv

Processes:
- Overview:
    - man 7 process
    - man 7 credentials
- Syscalls/Functions:
    - man 2 fork
    - man 2 execve
    - man 3 exec
    - man 2 wait
    - man 2 waitpid
    - man 2 exit
    - man 3 _exit
- Project:
    - write a shell with fork, exec, and wait
    - read a command, fork, child should execvp() and parent should waitpid(), print the exit status
    - add & for background jobs

Files, File Descriptors and I/O
- Overview:
    - man 7 file-hierarchy
    - man 7 path_resolution
    - man 7 inode
    - man 7 fd
- Syscalls/Functions:
    - man 2 open
    - man 2 close
    - man 2 read
    - man 2 write
    - man 2 lseek
    - man 2 stat
    - man 2 fstat
    - man 2 dup
    - man 2 dup2
- Project:
    - copy a file into another using open/read/write/close
    - support -p flag to preserve permissions
    - print throughput statistics

Signals:
- Overview:
    - man 7 signal
    - man 7 signal-safety
- Syscalls/Functions:
    - man 2 sigaction
    - man 2 sigprocmask
    - man 2 kill
    - man 2 pause
    - man 2 sigsuspend
- Project:
    - print a message on SIGINT, SIGTERM and SIGUSR1 using sigaction.
    - count signals using sig_atomic_t
    - block signals during critical sections?

IPC:
- [Beej guide to IPC](https://beej.us/guide/bgipc/html/)
- Overview:
    - man 7 ipc
    - man 7 pipe
    - man 7 fifo
    - man 7 shm_overview
    - man 7 sem_overview
    - man 7 mq_overview
- Syscalls/Functions:
    - man 2 pipe
    - man 2 mkfifo
    - man 2 shmget
    - man 2 shmat
    - man 2 semget
    - man 2 semop
    - man 3 mq_open
    - man 3 mq_send
- Project:
    - implement parent/child pipe using pipe, fork, dup2 and close
    - parent writes stdin to child, child echoes uppercase back to parent (use two pipes)
    - replace pipes with shared memory and semaphore.

Sockets and Networking:
- [Beej guide to network programming](https://beej.us/guide/bgnet/html/)
- Overview:
    - man 7 socket
    - man 7 ip
    - man 7 tcp
    - man 7 udp
    - man 7 unix (AF_UNIX sockets)
- Syscalls/Functions:
    - man 2 socket
    - man 2 bind
    - man 2 listen
    - man 2 accept
    - man 2 connect
    - man 2 send
    - man 2 recv
    - man 2 select
    - man 2 poll
    - man 7 epoll
- Project:
    - Write TCP echo server using socket, bind, listen, accept, send, recv
    - handle multiple clients with select

Memory Management:
- Overview:
    - man 7 memory
    - man 7 mmap
    - man 7 proc
- Syscalls/Functions:
    - man 2 brk
    - man 2 mmap
    - man 2 munmap
    - man 2 mprotect
    - man 3 malloc
    - man 3 mallopt
- Projects:
    - make a grep program that searchs for a string in a file using mmap/munmap/stat (no read)

Threads and Synchronisation:
- Overview:
    - man 7 pthreads
    - man 7 futex
- Functions:
    - man 3 pthread_create
    - man 3 pthread_join
    - man 3 pthread_mutex_lock
    - man 3 pthread_cond_wait
    - man 3 pthread_rwlock_*
- Project:
    - split an array accross N threads, each thread computes a partial sum, main thread aggregates results
    - initially use mutex, but then replace with atomic operations

Time and Scheduling:
- Overview:
    - man 7 time
- Syscalls/Functions:
    - man 2 clock_gettime
    - man 2 nanosleep
    - man 2 timerfd_create
    - man 2 sched_setscheduler
- Project:
    - print a timestamp every N milliseconds using a monotonic clock (clock_gettime/nanosleep/timerfd_create)
    - add drift correction

Advanced Linux Features:
- Overview:
    - man 7 capabilities
    - man 7 namespaces
    - man 7 cgroups
- Syscalls/Functions:
    - man 2 clone
    - man 2 unshare
    - man 2 prctl
    - man 2 io_uring_setup
- Project:
    - monitor a PID for memory usage, cpu time and num of open files (/proc/<pid>/stat, /proc/<pid>/status, open/read)
    - periodically update with timerfd

### Debugging
- use `strace` to see what syscalls are happening
- use rr instead of gdb? https://rr-project.org/











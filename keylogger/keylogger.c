#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <linux/input.h>
#include <string.h>

int main() {
    
    int fd = open("/dev/input/event0", O_RDONLY);
    if (fd == -1) {
        perror("Failed ... > please use `sudo`");
        return 1;
    }

    struct input_event ie;
    printf("Click any key\n");

    while (1) {
        read(fd, &ie, sizeof(struct input_event));
        if (ie.type == EV_KEY && ie.value == 1) {
            printf("clicked : %d\n", ie.code);
        }
    }

    close(fd);
    return 0;
}

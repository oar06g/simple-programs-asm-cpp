#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define WIDTH 40

void scroll_text(const char *text) {
    int len = strlen(text);
    char buffer[WIDTH + 1];

    for (int i = 0; i < WIDTH; i++) {
        buffer[i] = ' ';
    }
    buffer[WIDTH] = '\0';

    for (int i = 0; i < len + WIDTH; i++) {
        
        for (int j = 0; j < WIDTH; j++) {
            if (i - j >= 0 && i - j < len) {
                buffer[j] = text[i - j];
            } else {
                buffer[j] = ' ';
            }
        }
        printf("\r%s", buffer);
        fflush(stdout);
        usleep(200000);
    }
    printf("\n");
}

int main() {
    const char *text = "This is animated text on the screen!";
    scroll_text(text);
    return 0;
}
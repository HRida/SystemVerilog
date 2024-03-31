#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void readFile(const char *filename, char **buffer) {
    FILE *file = fopen(filename, "rb");
    fseek(file, 0, SEEK_END);
    
    long length = ftell(file);
    
    fseek(file, 0, SEEK_SET);
    *buffer = malloc(length);
    
    fread(*buffer, 1, length, file);
    
    fclose(file);
}

int compareBuffers(char *buffer1, char *buffer2, long length) {
    for (int i = 0; i < length; i++) {
        if (buffer1[i] != buffer2[i]) {
            return 0;
        }
    }
    return 1;
}

int main() {
    char *buffer1, *buffer2;

    readFile("output", &buffer1);
    readFile("output_expected", &buffer2);

    if (compareBuffers(buffer1, buffer2, strlen(buffer1))) {
        printf("Passed\n");
    } 
    else {
        printf("Failed\n");
    }

    free(buffer1);
    free(buffer2);

    return 0;
}
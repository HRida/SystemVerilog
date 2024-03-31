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

int compareBuffers(char *buffer1, char *buffer2, long length_1, long length_2) {
    char newBuffer1[length_1 - 6 + 1];
    
    strncpy(newBuffer1, &buffer1[3], length_1 - 6);

    newBuffer1[length_1 - 6] = '\0';

    /** Debugging
    printf("New Buffer1: %c ", newBuffer1[0]); // use %s for string
    printf("Length: %ld\n", length_1 - 6);
    
    printf("-------------------------\n");

    printf("Buffer1: %c ", buffer1[3]); 
    printf("Length: %ld\n", length_1);
    
    printf("-------------------------\n");
    
    printf("Buffer2: %c ", buffer2[0]);
    printf("Length: %ld\n", length_2);
    **/

    for (int i = 0; i < length_2; i++) {
        if (newBuffer1[i] != buffer2[i]) {
            return 0;
        }
    }
    return 1;
}

int main() {
    char *buffer1, *buffer2;

    readFile("output", &buffer1);
    readFile("output_expected", &buffer2);

    if (compareBuffers(buffer1, buffer2, strlen(buffer1), strlen(buffer2))) {
        printf("Passed\n");
    } 
    else {
        printf("Failed\n");
    }

    free(buffer1);
    free(buffer2);

    return 0;
}
#include <stdio.h>
#define N_ELEMENTS 4

int main() {
    FILE *file = fopen("rom_file.mem", "w+b");
    if (file == NULL) {
        printf("Error opening file\n");
        return 1;
    }

    unsigned char matrix[N_ELEMENTS][N_ELEMENTS];
    unsigned char value1 = 0x00; // '\0'

    for(int i = 0; i < N_ELEMENTS; i++) {
        for(int j = 0; j < N_ELEMENTS; j++) {
            matrix[i][j] = value1++;
            fprintf(file, "%02X ", matrix[i][j]);
        }
        fprintf(file, "\n");
    }

    fclose(file);

    return 0;
}
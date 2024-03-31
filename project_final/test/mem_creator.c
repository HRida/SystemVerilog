#include <stdio.h>

int main() {
    FILE *file = fopen("rom_file.mem", "w");
    if (file == NULL) {
        printf("Error opening file\n");
        return 1;
    }

    unsigned char matrix1[4][4];
    unsigned char value1 = 0x00; // '\0'

    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++) {
            matrix1[i][j] = value1++;
            fprintf(file, "%02X ", matrix1[i][j]);
        }
        fprintf(file, "\n");
    }

    fclose(file);

    return 0;
}
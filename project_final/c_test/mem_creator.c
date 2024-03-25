#include <stdio.h>

int main() {
    FILE *file1 = fopen("rom_file_1.mem", "w");
    if (file1 == NULL) {
        printf("Error opening file1\n");
        return 1;
    }

    unsigned char matrix1[4][4];
    unsigned char value1 = 0x00; // '\0'

    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++) {
            matrix1[i][j] = value1++;
            fprintf(file1, "%02X ", matrix1[i][j]);
        }
        fprintf(file1, "\n");
    }

    fclose(file1);

    ////////////////////////////////////////////////////////////////////
    
    FILE *file2 = fopen("rom_file_2.mem", "w");
    if (file2 == NULL) {
        printf("Error opening file2\n");
        return 1;
    }

    unsigned char matrix2[4][4];
    unsigned char value2 = 0x00; // '\0'

    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++) {
            matrix2[i][j] = value2++;
            fprintf(file2, "%02X ", matrix2[i][j]);
        }
        fprintf(file2, "\n");
    }

    fclose(file2);

    return 0;
}
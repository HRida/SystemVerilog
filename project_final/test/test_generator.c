#include <stdio.h>
#include <stdlib.h>

#define N_ELMENTS 4

void matmul(int **input1, int **input2, int **output, int size)
{
    int i, j, k;
    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size; j++)
        {
            for (k = 0; k < size; k++)
            {
                output[i][j] += input1[i][k] * input2[k][j];
            }
        }
    }
}

void fillMatrix(int **matrix, int size)
{
    int i, j, count = 0;
    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size; j++)
        {
            matrix[i][j] = count++;
        }
    }
}

void writeMatrix(int **matrix, int size)
{
	// File handelrs
	FILE *expectedOutput;
	expectedOutput = fopen("output_expected", "w");

    int i, j;
    for (i = 0; i < size; i++)
    {
        for (j = 0; j < size; j++)
        {
            fprintf(expectedOutput, "%02X\n", matrix[i][j]);
        }
    }

	// Closing file handlers
	fclose(expectedOutput);
}

void printMatrix(int **matrix, int size)
{
    int i, j;
    printf("Matrix:\n");
    for (i = 0; i < size; i++)
    {
        printf("[");
        for (j = 0; j < size; j++)
        {
            printf("%d ", matrix[i][j]);
        }
        printf("]\n");
    }
}

int main()
{
	// Variables
	int *M, *N, *P;

	// Creating test data
	int **input1 = (int **)malloc(N_ELMENTS * sizeof(int *));
    int **input2 = (int **)malloc(N_ELMENTS * sizeof(int *));
    int **output = (int **)malloc(N_ELMENTS * sizeof(int *));
    int i;
    for (i = 0; i < N_ELMENTS; i++)
    {
        input1[i] = (int *)malloc(N_ELMENTS * sizeof(int));
        input2[i] = (int *)malloc(N_ELMENTS * sizeof(int));
        output[i] = (int *)malloc(N_ELMENTS * sizeof(int));
    }

	// Filling up the matrices
	fillMatrix(input1, N_ELMENTS);
	printMatrix(input1, N_ELMENTS);
    
	fillMatrix(input2, N_ELMENTS);
	printMatrix(input2, N_ELMENTS);

	// Multiplying the matrices
	matmul(input1, input2, output, N_ELMENTS);

	// Printing the matrices
	writeMatrix(output, N_ELMENTS);

	return 0;
}
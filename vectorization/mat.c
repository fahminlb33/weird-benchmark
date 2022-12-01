#include <stdio.h>

#define N 1024

float matrix_a[N][N];
float matrix_b[N][N];
float result_matrix[N][N];

void chunked_mm(int chunk, int n_chunks) {
    for (int i = chunk*(N/n_chunks); i < (chunk+1)*(N/n_chunks); i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                result_matrix[i][j] += matrix_a[i][k] * matrix_b[k][j];
            }
        }
    }
}

int main(int argc, char **argv) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            matrix_a[i][j] = 0.1f;
            matrix_b[i][j] = 0.2f;
            result_matrix[i][j] = 0.0f;
        }
    }
    //#pragma omp parallel for
    for (int chunk = 0; chunk < 4; chunk++) {
        chunked_mm(chunk, 4);
    }
 
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%f ", result_matrix[i][j]);
        }
        printf("\n");
    }
}

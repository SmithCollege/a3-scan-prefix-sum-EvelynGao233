#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// test different size
int sizes[] = {100, 1000, 10000, 100000, 1000000, 10000000, 100000000};

int main() {
    for (int s = 0; s < 7; s++) {
        int SIZE = sizes[s];

        // Allocate memory
        int* input = malloc(sizeof(int) * SIZE);
        int* output = malloc(sizeof(int) * SIZE);

        // Initialize inputs
        for (int i = 0; i < SIZE; i++) {
            input[i] = 1;
        }

        // Timing start
        clock_t start = clock();

        // Prefix sum (scan)
        output[0] = input[0];
        for (int i = 1; i < SIZE; i++) {
            output[i] = output[i - 1] + input[i];
        }

        // Timing end
        clock_t end = clock();
        double total_time = ((double)(end - start)) / CLOCKS_PER_SEC * 1000.0;

        // Print the time taken for each size
        printf("Size: %d, Time taken (CPU): %f ms\n", SIZE, total_time);

        // Print first 10 results to test (for the largest size only)
        if (s == 6) {
            for (int i = 0; i < 10; i++) {
                printf("%d ", output[i]);
            }
            printf("\n");
        }

        // Free memory
        free(input);
        free(output);
    }

    return 0;
}

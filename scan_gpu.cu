#include <stdio.h>
#include <cuda.h>

int sizes[] = {100, 1000, 10000, 100000, 1000000, 10000000, 100000000};

// naive
__global__ void naivePrefixScan(int* input, int* output, int size) {
    int index = threadIdx.x + blockIdx.x * blockDim.x;

    if (index >= size) return;

    int value = 0;

    for (int j = 0; j <= index; j++) {
        value += input[j];
    }

    output[index] = value;
}

// recursive doubling
__global__ void recursivePrefixScan(int* input, int* output, int size) {
    extern __shared__ int temp[];
    int index = threadIdx.x + blockIdx.x * blockDim.x;

    if (index >= size) return;

    temp[threadIdx.x] = input[index];
    __syncthreads();

    for (int stride = 1; stride < blockDim.x; stride *= 2) {
        int tempVal = 0;
        if (threadIdx.x >= stride) {
            tempVal = temp[threadIdx.x - stride];
        }
        __syncthreads();
        temp[threadIdx.x] += tempVal;
        __syncthreads();
    }

    output[index] = temp[threadIdx.x];
}

int main() {
    for (int s = 0; s < 7; s++) {
        int SIZE = sizes[s];

        int* input;
        int* output;

        cudaMallocManaged(&input, SIZE * sizeof(int));
        cudaMallocManaged(&output, SIZE * sizeof(int));

        for (int i = 0; i < SIZE; i++) {
            input[i] = 1;
        }

        int threadsPerBlock = (SIZE < 256) ? SIZE : 256;
        int blocksPerGrid = (SIZE + threadsPerBlock - 1) / threadsPerBlock;

        // learned from cuda post: https://developer.nvidia.com/blog/how-implement-performance-metrics-cuda-cc/
        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);

        cudaEventRecord(start);

        // naivePrefixScan<<<blocksPerGrid, threadsPerBlock>>>(input, output, SIZE);
        recursivePrefixScan<<<blocksPerGrid, threadsPerBlock, threadsPerBlock * sizeof(int)>>>(input, output, SIZE);

        cudaDeviceSynchronize();

        cudaEventRecord(stop);
        cudaEventSynchronize(stop);

        float milliseconds = 0;
        cudaEventElapsedTime(&milliseconds, start, stop);

        // Print time taken for each size
        printf("Size: %d, Time taken (GPU): %f ms\n", SIZE, milliseconds);

        // Print first 10 results for the largest size only
        if (s == 6) {
            for (int i = 0; i < 10; i++) {
                printf("%d ", output[i]);
            }
            printf("\n");
        }

        // Free memory
        cudaFree(input);
        cudaFree(output);
    }

    return 0;
}

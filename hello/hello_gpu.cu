#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function computing the final string to print */
__global__ void compute_string(char *res, char *a, char *b, char *c,
                               int length) {
  int i;

  i = blockIdx.x * blockDim.x + threadIdx.x;

  id(i < N) { res[i] = a[i] + b[i] + c[i]; }
}

int main() {

  char *res;

  char a[30] = {40, 70, 70, 70, 80, 0, 50, 80, 80, 70, 70, 0,  40, 80, 79,
                70, 0,  40, 50, 50, 0, 70, 80, 0,  30, 50, 30, 30, 0,  0};
  char b[30] = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 0,  0};
  char c[30] = {22, 21, 28, 28, 21, 22, 27, 21, 24, 28, 20, 22, 20, 24, 22,
                29, 22, 21, 20, 25, 22, 25, 20, 22, 27, 25, 28, 25, 0,  0};

  res = (char *)malloc(30 * sizeof(char));

  /* This function call should be programmed in CUDA */
  /* -> need to allocate and transfer data to/from the device */

  char *da, *db, *dc, *dres;
  cudaMalloc(&da, 30);
  cudaMalloc(&db, 30);
  cudaMalloc(&dc, 30);
  cudaMalloc(&dres, 30);

  cudaMemcpy(da, a, 30, cudaMemcpyHostToDevice);
  cudaMemcpy(db, b, 30, cudaMemcpyHostToDevice);
  cudaMemcpy(dc, c, 30, cudaMemcpyHostToDevice);

  int nb_thr = 6;
  int nb_blk = 5;

  compute_string<<<nb_blk, nb_thr>>>(dres, da, db, dc, 30);

  cudaMemcpy(res, dres, 30, cudaMemcpyHostToDevice);
  printf("%s\n", res);

  cudaFree(da);
  cudaFree(db);
  cudaFree(dc);
  cudaFree(dres);

  free(res);

  return 0;
}

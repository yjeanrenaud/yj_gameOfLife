//We keep the grid size fixed at runtime but allocated dynamically for better performance, bigger grid sizes and to change it dynamically during runtime
#include <stdio.h>
#include <stdlib.h>

void yj_initializeGrid(int*** grid, int rows, int cols) {
    *grid = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        (*grid)[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            (*grid)[i][j] = 0;
        }
    }
}

void yj_freeGrid(int*** grid, int rows) {
    for (int i = 0; i < rows; i++) {
        free((*grid)[i]);
    }
    free(*grid);
}

void yj_calcGrid(int** grid, int** nextGen, int rows, int cols, int** result, int* resultCount) {
    int directions[8][2] = {
        {-1, -1}, {-1, 0}, {-1, 1},
        { 0, -1},          { 0, 1},
        { 1, -1}, { 1, 0}, { 1, 1}
    };

    *resultCount = 0;
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            int liveNeighbors = 0;
            for (int i = 0; i < 8; i++) {
                int newRow = row + directions[i][0];
                int newCol = col + directions[i][1];
                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == 1) {
                    liveNeighbors++;
                }
            }

            if ((grid[row][col] == 1) && (liveNeighbors == 2 || liveNeighbors == 3)) {
                nextGen[row][col] = 1;
            } else if ((grid[row][col] == 0) && (liveNeighbors == 3)) {
                nextGen[row][col] = 1;
            } else {
                nextGen[row][col] = 0;
            }

            if (nextGen[row][col] == 1) {
                (*result)[*resultCount] = row * cols + col; // Encode 2D position as 1D
                (*resultCount)++;
            }
        }
    }
}

/* 
  //example usage:
int main() {
    int rows = 5, cols = 5;
    int** grid;
    int** nextGen;
    int* result = (int*)malloc(rows * cols * sizeof(int)); // Simplified result collection
    int resultCount = 0;

    initializeGrid(&grid, rows, cols);
    initializeGrid(&nextGen, rows, cols);

    grid[1][2] = 1;
    grid[2][2] = 1;
    grid[3][2] = 1;

    yj_calcGrid(grid, nextGen, rows, cols, &result, &resultCount);

    printf("Cells alive in the next generation:\n");
    for (int i = 0; i < resultCount; i++) {
        printf("(%d, %d)\n", result[i] / cols, result[i] % cols);
    }

    freeGrid(&grid, rows);
    freeGrid(&nextGen, rows);
    free(result);

    return 0;
}
*/

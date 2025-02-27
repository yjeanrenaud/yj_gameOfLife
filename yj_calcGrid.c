/*
 * C function for the Game of Life
 * https://github.com/yjeanrenaud/yj_gameOfLife/tree/main
 * 2025, Yves Jeanrenaud
 */

#define MAX_ROWS 100
#define MAX_COLS 100 // use malloc for larger grids

void yj_calcGrid(int rows, int cols, int initialLiveCells[][2], int initialLiveCellsCount, int result[][2], int* resultCount) {
    int grid[MAX_ROWS][MAX_COLS] = {0};
    int nextGen[MAX_ROWS][MAX_COLS] = {0};
    
    // Grid with initially alive cells
    for (int i = 0; i < initialLiveCellsCount; i++) {
        int row = initialLiveCells[i][0];
        int col = initialLiveCells[i][1];
        grid[row][col] = 1;
    }
    
    // Directions to neighbouring cells
    int directions[8][2] = {
        {-1, -1}, {-1, 0}, {-1, 1},
        { 0, -1},          { 0, 1},
        { 1, -1}, { 1, 0}, { 1, 1}
    };
    
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            int liveNeighbors = 0;
            
            // Count live neighbours
            for (int i = 0; i < 8; i++) {
                int newRow = row + directions[i][0];
                int newCol = col + directions[i][1];
                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == 1) {
                    liveNeighbors++;
                }
            }
            
            // Apply the rules
            if ((grid[row][col] == 1) && (liveNeighbors == 2 || liveNeighbors == 3)) {
                nextGen[row][col] = 1;
            } else if ((grid[row][col] == 0) && (liveNeighbors == 3)) {
                nextGen[row][col] = 1;
            }
        }
    }
    
    // Collect the coordinates those alive
    *resultCount = 0;
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            if (nextGen[row][col] == 1) {
                if (*resultCount < MAX_ROWS * MAX_COLS) {
                    result[*resultCount][0] = row;
                    result[*resultCount][1] = col;
                    (*resultCount)++;
                }
            }
        }
    }
}
/*
  // example usage:
#include <stdio.h>
int main() {
    int rows = 5, cols = 5;
    int arrInitialLiveCells[][2] = {{1, 2}, {2, 2}, {3, 2}};
    int initialLiveCellsCount = 3;
    int arrResult[MAX_ROWS * MAX_COLS][2], resultCount = 0;
    
    yj_calcGrid(rows, cols, arrInitialLiveCells, initialLiveCellsCount, arrResult, &resultCount);
    
    printf("Cells alive in the next generation:\n");
    for (int i = 0; i < resultCount; i++) {
        printf("(%d, %d)\n", arrResult[i][0], arrResult[i][1]);
    }
    
    return 0;
}
*/

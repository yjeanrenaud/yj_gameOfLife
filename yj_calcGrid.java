import java.util.ArrayList;
import java.util.List;

public class yj_calcGrid {
    
    public List<int[]> nextGeneration(int rows, int cols, List<int[]> initialLiveCells) {
        // Empty grid
        int[][] grid = new int[rows][cols];
        
        // Living cells are turned on (1)
        for (int[] cell : initialLiveCells) {
            grid[cell[0]][cell[1]] = 1;
        }
        
        // Directions to move to the neighbouring cells
        int[][] directions = {
            {-1, -1}, {-1, 0}, {-1, 1},
            {0, -1},           {0, 1},
            {1, -1},  {1, 0},  {1, 1}
        };
        
        // Grid to store the next generation
        int[][] nextGen = new int[rows][cols];
        
        for (int row = 0; row < rows; row++) {
            for (int col = 0; col < cols; col++) {
                int liveNeighbors = 0;
                
                // Count live neighbors
                for (int[] d : directions) {
                    int newRow = row + d[0], newCol = col + d[1];
                    if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == 1) {
                        liveNeighbors++;
                    }
                }
                
                // Apply the rules™️
                if (grid[row][col] == 1 && (liveNeighbors == 2 || liveNeighbors == 3)) {
                    nextGen[row][col] = 1;
                } else if (grid[row][col] == 0 && liveNeighbors == 3) {
                    nextGen[row][col] = 1;
                }
            }
        }
        
        // Collect the coordinates of cells alive
        List<int[]> liveCellsNextGen = new ArrayList<>();
        for (int row = 0; row < rows; row++) {
            for (int col = 0; col < cols; col++) {
                if (nextGen[row][col] == 1) {
                    liveCellsNextGen.add(new int[] {row, col});
                }
            }
        }
        
        return liveCellsNextGen;
    }
/* // Example usage:
    public static void main(String[] args) {
        yj_calcGrid game = new yj_calcGrid();
        int rows = 5, cols = 5;
        List<int[]> initialLiveCells = new ArrayList<>();
        initialLiveCells.add(new int[] {1, 2});
        initialLiveCells.add(new int[] {2, 2});
        initialLiveCells.add(new int[] {3, 2});
        
        List<int[]> nextGenLiveCells = game.nextGeneration(rows, cols, initialLiveCells);
        
        System.out.println("Cells alive in the next generation:");
        for (int[] cell : nextGenLiveCells) {
            System.out.println("(" + cell[0] + ", " + cell[1] + ")");
        }
    }
    */
}

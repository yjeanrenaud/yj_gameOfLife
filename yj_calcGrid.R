#! /usr/bin/env python3
##
# R function for the Game of Life
# https://github.com/yjeanrenaud/yj_gameOfLife/tree/main
# 2025, Yves Jeanrenaud
##
yj_calcGrid <- function(initialGrid) {
  # Define the dimensions of the grid
  rows <- nrow(initialGrid)
  cols <- ncol(initialGrid)
  
  # Create a matrix to store the next generation
  nextGrid <- matrix(0, nrow = rows, ncol = cols)
  
  # Define the relative positions of the eight neighbours
  neighbours <- expand.grid(row = -1:1, col = -1:1)
  neighbours <- subset(neighbours, row != 0 | col != 0)
  
  # Iterate over each cell in the grid
  for (row in 1:rows) {
    for (col in 1:cols) {
      # Calculate the row and column indices of the neighbours
      neighbourRows <- pmin(pmax(row + neighbours$row, 1), rows)
      neighbourCols <- pmin(pmax(col + neighbours$col, 1), cols)
      
      # Count the number of neighbours alive
      liveneighbours <- sum(initialGrid[cbind(neighbourRows, neighbourCols)])
      
      # Apply the rules
      if (initialGrid[row, col] == 1 && (liveneighbours == 2 || liveneighbours == 3)) {
        nextGrid[row, col] <- 1
      } else if (initialGrid[row, col] == 0 && liveneighbours == 3) {
        nextGrid[row, col] <- 1
      }
    }
  }
  # return the new grid
  return(nextGrid)
}

# Example usage
rows <- 5
cols <- 5
initialGrid <- matrix(0, nrow = rows, ncol = cols)
initialGrid[2, 3] <- 1
initialGrid[3, 3] <- 1
initialGrid[4, 3] <- 1

# Run one iteration of the game
nextGrid <- yj_calcGrid(initialGrid)

# Print the next generation grid
print(nextGrid)

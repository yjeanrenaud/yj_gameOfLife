#! /usr/bin/env python3
##
# python function for the Game of Life
# https://github.com/yjeanrenaud/yj_gameOfLife/tree/main
# 2025, Yves Jeanrenaud
##

def yj_calcGrid(size, initial_live_cells):
"""
this function calculates the state of the next generation according to the rules™. It requires the Size of the grid to play on as a list and a list of cells that are currently alive
"""
    # Initialize the grid with all cells turned OFF
    grid = [[0 for _ in range(size[0])] for _ in range(size[1])]
    
    # Turn ON the cells that are initially alive
    for cell in initial_live_cells:
        grid[cell[0]][cell[1]] = 1
    
    # Count live neighbors
    def count_live_neighbors(x, y):
        directions = [(-1, -1), (-1, 0), (-1, 1),
                      (0, -1),           (0, 1),
                      (1, -1),  (1, 0),  (1, 1)]
        count = 0
        for dx, dy in directions:
            nx, ny = x + dx, y + dy
            if 0 <= nx < size[0] and 0 <= ny < size[1]:
                count += grid[nx][ny]
        return count
    
    # New grid of arbitary size to store the next generation
    next_gen = [[0 for _ in range(size[0])] for _ in range(size[1])]
    
    # Apply the rules of the Game to each cell
    for x in range(size[0]):
        for y in range(size[1]):
            live_neighbors = count_live_neighbors(x, y)
            if grid[x][y] == 1 and (live_neighbors == 2 or live_neighbors == 3):
                next_gen[x][y] = 1  # Cell stays alive
            elif grid[x][y] == 0 and live_neighbors == 3:
                next_gen[x][y] = 1  # Cell becomes alive
    
    # Collect the coordinates of cells that are alive now
    live_cells_next_gen = [(x, y) for x in range(size[0]) for y in range(size[1]) if next_gen[x][y] == 1]
    
    return live_cells_next_gen

"""
Example usage:
 size = (5, 5)  # Grid size (width, height)
 initial_live_cells = [(1, 2), (2, 2), (3, 2)]  # Initial live cells
 next_gen_live_cells = game_of_life(size, initial_live_cells)
 print("Cells alive in the next generation:", next_gen_live_cells)
"""

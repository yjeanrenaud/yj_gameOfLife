#! /usr/bin/env python3
##
# pygame sample on how to use the yj_calcGrid function
# https://github.com/yjeanrenaud/yj_gameOfLife/tree/main
# 2025, Yves Jeanrenaud
##
from yj_calcGrid import yj_calcGrid
import pygame
# yj_calcGrid.py

pygame.init()

# Grid parameters (using a square grid so that the indexing ambiguity is not an issue)
grid_size = (50, 50)  # (rows, columns) - must be equal for the provided code to work unmodified
cell_size = 10  # Pixel size for each cell

# Set up the display window dimensions
window_width = grid_size[1] * cell_size
window_height = grid_size[0] * cell_size
screen = pygame.display.set_mode((window_width, window_height))
pygame.display.set_caption("Game of Life Visualization")

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

# Initial live cells pattern (a glider pattern is used here)
# Note: The provided function treats the first value as the row and the second as the column.
initial_live_cells = [(1, 2), (2, 3), (3, 1), (3, 2), (3, 3)]
current_live_cells = initial_live_cells

clock = pygame.time.Clock()

running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    screen.fill(WHITE)
    
    # Draw live cells
    # Here, cell[0] is the row (y-coordinate) and cell[1] is the column (x-coordinate)
    for cell in current_live_cells:
        x = cell[1] * cell_size  # Column determines the x position
        y = cell[0] * cell_size  # Row determines the y position
        pygame.draw.rect(screen, BLACK, (x, y, cell_size, cell_size))
    
    pygame.display.flip()
    clock.tick(10)  # Set the frame rate (10 generations per second)
    
    # Update the grid to the next generation using the function
    current_live_cells = yj_calcGrid(grid_size, current_live_cells)

pygame.quit()

% MATHLAB function for the Game of Life using malloc.
% https://github.com/yjeanrenaud/yj_gameOfLife/tree/main
% 2024, Yves Jeanrenaud

function nextGrid = yj_calcGrid(rows, cols, initialGrid)
    % Extend the grid with a border to simplify neighbour calculations
    extendedGrid = zeros(rows+2, cols+2);
    extendedGrid(2:end-1, 2:end-1) = initialGrid;
    
    nextGrid = zeros(rows, cols); % Initialize the next generation grid
    
    for row = 1:rows
        for col = 1:cols
            % Count live neighbours
            liveneighbours = sum(sum(extendedGrid(row:row+2, col:col+2))) - extendedGrid(row+1, col+1);
            
            % Apply the Game of Life rules
            if extendedGrid(row+1, col+1) == 1
                % Cell is currently alive
                if liveneighbours == 2 || liveneighbours == 3
                    nextGrid(row, col) = 1; % Cell stays alive
                end
            else
                % Cell is currently dead
                if liveneighbours == 3
                    nextGrid(row, col) = 1; % Cell becomes alive
                end
            end
        end
    end
end

% Example usage
rows = 5;
cols = 5;
initialGrid = zeros(rows, cols);
initialGrid(2,3) = 1; % Define initial live cells
initialGrid(3,3) = 1;
initialGrid(4,3) = 1;

nextGrid = yj_calcGrid(rows, cols, initialGrid);
disp(nextGrid);

function yj_calcGrid(rows, cols, initialGrid) {
    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [ 0, -1],          [ 0, 1],
        [ 1, -1], [ 1, 0], [ 1, 1]
    ];

    let nextGrid = Array.from(Array(rows), () => new Array(cols).fill(0));

    for (let row = 0; row < rows; row++) {
        for (let col = 0; col < cols; col++) {
            let liveNeighbours = 0;

            directions.forEach(([dx, dy]) => {
                const newRow = row + dx;
                const newCol = col + dy;

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && initialGrid[newRow][newCol] === 1) {
                    liveNeighbours++;
                }
            });

            const isAlive = initialGrid[row][col] === 1;
            if (isAlive && (liveNeighbours === 2 || liveNeighbours === 3)) {
                nextGrid[row][col] = 1;
            } else if (!isAlive && liveNeighbours === 3) {
                nextGrid[row][col] = 1;
            }
        }
    }

    return nextGrid;
}

/* // Example usage

const rows = 5;
const cols = 5;
const initialGrid = Array.from(Array(rows), () => new Array(cols).fill(0));
initialGrid[1][2] = 1;
initialGrid[2][2] = 1;
initialGrid[3][2] = 1;

const nextGrid = yj_calcGrid(rows, cols, initialGrid);

console.log("Next Generation:");
console.log(nextGrid);
*/

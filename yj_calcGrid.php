<?php

function yj_calcGrid($rows, $cols, $initialGrid) {
    $nextGenGrid = array_fill(0, $rows, array_fill(0, $cols, 0));

    for ($row = 0; $row < $rows; $row++) {
        for ($col = 0; $col < $cols; $col++) {
            $liveneighbours = 0;

            // Check all eight directions
            for ($i = -1; $i <= 1; $i++) {
                for ($j = -1; $j <= 1; $j++) {
                    if ($i == 0 && $j == 0) continue; // Skip the cell itself

                    $x = $row + $i;
                    $y = $col + $j;

                    // Check the bounds and count the live neighbour
                    if ($x >= 0 && $x < $rows && $y >= 0 && $y < $cols && $initialGrid[$x][$y] == 1) {
                        $liveneighbours++;
                    }
                }
            }

            // Apply the rules
            if ($initialGrid[$row][$col] == 1 && ($liveneighbours == 2 || $liveneighbours == 3)) {
                $nextGenGrid[$row][$col] = 1;
            } else if ($initialGrid[$row][$col] == 0 && $liveneighbours == 3) {
                $nextGenGrid[$row][$col] = 1;
            }
        }
    }

    return $nextGenGrid;
}

/*
// Example usage
$rows = 5;
$cols = 5;
$initialGrid = array_fill(0, $rows, array_fill(0, $cols, 0));
$initialGrid[1][2] = 1;
$initialGrid[2][2] = 1;
$initialGrid[3][2] = 1;

$nextGenGrid = yj_calcGrid($rows, $cols, $initialGrid);

// Output the grid
foreach ($nextGenGrid as $row) {
    foreach ($row as $cell) {
        echo $cell ? "1 " : "0 ";
    }
    echo PHP_EOL;
}
*/

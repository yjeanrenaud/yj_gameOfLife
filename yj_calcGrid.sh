#!/usr/bin/env bash

# Initialise variables
rows=5
cols=5
generations=1

# Initial grid with live cells
declare -A grid=(
    [2,3]=1
    [3,3]=1
    [4,3]=1
)

yj_printGrid() {
    for ((i=1; i<=rows; i++)); do
        for ((j=1; j<=cols; j++)); do
            if [[ ${grid[$i,$j]} -eq 1 ]]; then
                printf "*"
            else
                printf "."
            fi
        done
        echo
    done
}

yj_calcGrid() {
    declare -A newGrid
    for ((i=1; i<=rows; i++)); do
        for ((j=1; j<=cols; j++)); do
            liveNeighbours=0
            for di in {-1,0,1}; do
                for dj in {-1,0,1}; do
                    if [[ $di -eq 0 && $dj -eq 0 ]]; then
                        continue
                    fi
                    ni=$((i + di))
                    nj=$((j + dj))
                    if [[ ${grid[$ni,$nj]} -eq 1 ]]; then
                        ((liveNeighbours++))
                    fi
                done
            done
            if [[ ${grid[$i,$j]} -eq 1 ]]; then
                if [[ $liveNeighbours -eq 2 || $liveNeighbours -eq 3 ]]; then
                    newGrid[$i,$j]=1
                fi
            else
                if [[ $liveNeighbours -eq 3 ]]; then
                    newGrid[$i,$j]=1
                fi
            fi
        done
    done
    grid=("${newGrid[@]}")
}

echo "Initial grid:"
print_grid
for ((g=1; g<=generations; g++)); do
    yj_calcGrid
    echo "Generation $g:"
    yj_printGrid
done

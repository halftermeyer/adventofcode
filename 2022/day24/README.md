# Day 24: Blizzard Basin
[Problem](https://adventofcode.com/2022/day/24) | **Graph**: Space-Time Graph + GDS | **CS**: Dijkstra in space-time

## Graph Model
`(:Cell)` nodes indexed by `(row, col, time)` forming a space-time graph. Each cell at time `t` connects to reachable cells at time `t+1` (including waiting in place). Blizzard positions are computed modularly.

## Approach
Expand the grid into a space-time graph where each node represents a position at a specific time step. Blizzard positions repeat with a period equal to the LCM of grid dimensions, so only one cycle of time layers is needed. Use GDS Dijkstra to find the shortest path from start to end through the space-time graph. Part 2 chains three trips (start-end-start-end).

## Key Techniques
- Space-time graph expansion with modular blizzard dynamics
- GDS Dijkstra for shortest path in the expanded graph
- Trip chaining for the three-leg journey (Part 2)

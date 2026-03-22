# Day 14: Regolith Reservoir
[Problem](https://adventofcode.com/2022/day/14) | **Graph**: Grid Graph (Point nodes) | **CS**: Sand/gravity simulation

## Graph Model
`(:Point)` nodes representing grid positions, connected by `[:FALLS]` relationships with priority weights (down = 1, down-left = 2, down-right = 3). Rock and sand states are tracked as node labels.

## Approach
Build a grid of points with rock walls from the input. Create weighted FALLS relationships encoding sand's movement priority (straight down first, then diagonals). Simulate sand grains dropping from the source, following the highest-priority available FALLS edge until resting. Part 1 stops when sand falls into the abyss; Part 2 adds a floor.

## Key Techniques
- Priority-weighted FALLS relationships for movement rules
- Iterative sand simulation with rest detection
- Floor extension for Part 2

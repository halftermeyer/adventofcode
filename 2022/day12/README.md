# Day 12: Hill Climbing
[Problem](https://adventofcode.com/2022/day/12) | **Graph**: Grid Graph (Square nodes) + GDS | **CS**: Dijkstra shortest path

## Graph Model
`(:Square)` nodes arranged in a grid, connected by `[:CAN_REACH]` relationships where the elevation difference is at most +1. Start (`S`) and End (`E`) nodes are marked.

## Approach
Build an elevation grid graph and create directed edges only where the destination is at most one elevation level higher. Use GDS Dijkstra to find the shortest path from S to E. Part 2 finds the shortest path from any square at elevation `a` to E by running Dijkstra from E in reverse.

## Key Techniques
- Elevation-filtered directed edge construction
- GDS Dijkstra for shortest path computation
- Reverse search from E for Part 2 multi-source shortest path

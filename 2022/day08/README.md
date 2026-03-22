# Day 8: Treetop Tree House
[Problem](https://adventofcode.com/2022/day/8) | **Graph**: Grid Graph with EAST/SOUTH/WEST/NORTH | **CS**: Visibility analysis

## Graph Model
`(:Tree)` nodes arranged in a grid, connected by `[:EAST]`, `[:WEST]`, `[:NORTH]`, `[:SOUTH]` relationships to their direct neighbors. Each tree stores its height.

## Approach
Link trees in four cardinal directions. Iteratively compute horizon heights (the maximum height seen so far from each edge) by propagating along directional relationships. A tree is visible if its height exceeds the horizon in any direction. Part 2 computes scenic scores by counting visible trees in each direction.

## Key Techniques
- 4-directional grid graph construction
- Iterative horizon height propagation via `apoc.periodic.commit`
- Visibility and scenic score calculation from directional data

# Day 18: Boiling Boulders
[Problem](https://adventofcode.com/2022/day/18) | **Graph**: 3D Grid (Cube nodes) | **CS**: Connected components + flood fill

## Graph Model
`(:Cube)` nodes at 3D integer coordinates, connected by `[:ADJACENT]` relationships to their 6 face-sharing neighbors. Air and lava cubes are distinguished by labels.

## Approach
Create cube nodes for all lava positions and link adjacent cubes in 3D (6-connectivity). Part 1 counts exposed faces (faces not shared with another lava cube). Part 2 performs a BFS flood fill from an external air node to identify all external air cubes, then counts only faces touching external air.

## Key Techniques
- 3D adjacency graph construction (6-connectivity)
- Exposed face counting via missing neighbor check
- BFS flood fill to distinguish external vs trapped air

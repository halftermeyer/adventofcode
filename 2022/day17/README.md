# Day 17: Pyroclastic Flow
[Problem](https://adventofcode.com/2022/day/17) | **Graph**: Grid Graph (Pixel nodes) | **CS**: Falling block simulation

## Graph Model
`(:Pixel)` nodes forming a grid, connected by directional relationships. Rock shapes are defined as pixel patterns that are placed and moved on the grid.

## Approach
Build a pixel grid representing the chamber. Simulate falling rocks by placing shape pixels, applying jet pushes (left/right) and gravity (down) each step, and freezing rocks in place when they can no longer fall. Part 2 detects a cycle in the tower height pattern to extrapolate to 1 trillion rocks.

## Key Techniques
- Pixel-level grid graph for chamber representation
- Jet pattern simulation with collision detection
- Cycle detection for Part 2 extrapolation

# Day 23: Unstable Diffusion
[Problem](https://adventofcode.com/2022/day/23) | **Graph**: Coordinate Grid | **CS**: Multi-agent simulation

## Graph Model
`(:Elf)` nodes with `(row, col)` coordinate properties. No persistent edges; neighbor checks are performed dynamically each round.

## Approach
Track elf positions on a coordinate grid. Each round, elves propose moves based on a rotating priority of directions (N, S, W, E), checking for neighbors. If multiple elves propose the same destination, none of them move (conflict resolution). Part 1 counts empty tiles in the bounding box after 10 rounds; Part 2 finds the first round where no elf moves.

## Key Techniques
- Coordinate-based neighbor lookup
- Rotating direction priority per round
- Conflict resolution: duplicate proposals cancel out

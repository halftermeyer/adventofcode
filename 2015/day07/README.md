# Day 7: Some Assembly Required
[Problem](https://adventofcode.com/2015/day/7) | **Graph**: DAG (wire dependencies) | **CS**: Topological evaluation / circuit simulation

## Approach
Parse 339 wire instructions. Iteratively resolve wires whose inputs are known via `reduce()` (209 iterations needed). Bitwise AND/OR implemented via bit decomposition (16-bit). Part 2: override wire `b` with Part 1 answer, re-simulate.

## Graph Model
```
(:Wire {name, value}) -- implicit DAG via instruction dependencies
```
Not materialized as graph; solved purely functionally with iterative resolution.

## Answers
| Part | Answer |
|------|--------|
| 1 | 46065 |
| 2 | 14134 |

# Day 1: Calorie Counting
[Problem](https://adventofcode.com/2022/day/1) | **Graph**: None | **CS**: Aggregation

## Graph Model
None — pure functional. Input is loaded via LOAD CSV and processed with collection operations.

## Approach
Load the input with LOAD CSV, split groups by empty lines using apoc.coll.split, then sum calories per elf group. Part 1 returns the maximum sum; Part 2 sums the top 3 using ORDER BY and LIMIT.

## Key Techniques
- LOAD CSV for input parsing
- `apoc.coll.split` to group lines by blank-line separators
- Aggregation with `sum`, `ORDER BY DESC`, and `LIMIT`

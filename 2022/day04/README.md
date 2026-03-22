# Day 4: Camp Cleanup
[Problem](https://adventofcode.com/2022/day/4) | **Graph**: None | **CS**: Range overlap

## Graph Model
None — pure functional. Ranges are parsed as integer pairs and compared directly.

## Approach
Parse each line into two integer ranges. Part 1 checks if one range fully contains the other; Part 2 checks if the ranges overlap at all. Both use simple boolean comparisons on range endpoints.

## Key Techniques
- String splitting and integer parsing for range extraction
- Boolean range containment: `a1 <= b1 AND b2 <= a2`
- Boolean range overlap: `a1 <= b2 AND b1 <= a2`

# Day 15: Beacon Exclusion Zone
[Problem](https://adventofcode.com/2022/day/15) | **Graph**: None (coordinate math) | **CS**: Interval merging

## Graph Model
None — pure functional. Sensor and beacon positions are processed as coordinate pairs with Manhattan distance calculations.

## Approach
For each sensor, compute the Manhattan distance to its closest beacon, then project the exclusion zone onto the target row as an interval. Merge overlapping intervals to find the total excluded range. Part 1 counts excluded positions on row 2000000; Part 2 scans rows to find the one gap not covered by any sensor.

## Key Techniques
- Manhattan distance calculation
- Interval projection and merging
- Row-by-row scanning for the uncovered gap (Part 2)

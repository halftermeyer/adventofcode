# Day 17: No Such Thing as Too Much
[Problem](https://adventofcode.com/2015/day/17) | **Graph**: None | **CS**: Subset sum

## Approach
20 containers, enumerate all 2^20 = 1,048,576 subsets via bitmask. For each bitmask, sum selected container sizes and check if total equals 150. Part 1: count valid subsets. Part 2: among valid subsets, find those using the minimum number of containers.

## Answers
| Part | Answer |
|------|--------|
| 1 | 1304 |
| 2 | 18 |

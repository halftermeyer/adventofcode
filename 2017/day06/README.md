# Day 6: Memory Reallocation
[Problem](https://adventofcode.com/2017/day/6) | **Graph**: None | **CS**: Cycle detection (seen states)
## Approach
Simulate bank redistribution: find bank with most blocks, distribute them round-robin. Track seen states as serialized strings. Part 1: steps until first repeat. Part 2: cycle length (difference between first and second occurrence).
## Answers
| Part | Answer |
|------|--------|
| 1 | 3156 |
| 2 | 1610 |

# Day 9: Stream Processing
[Problem](https://adventofcode.com/2017/day/9) | **Graph**: None | **CS**: Nested parser (garbage, groups)
## Approach
Single-pass state machine: track depth, whether inside garbage, and whether next char is cancelled. Part 1: sum group scores (depth at each '{' open). Part 2: count non-cancelled characters inside garbage.
## Answers
| Part | Answer |
|------|--------|
| 1 | 17390 |
| 2 | 7825 |

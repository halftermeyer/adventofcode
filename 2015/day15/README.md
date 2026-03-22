# Day 15: Science for Hungry People
[Problem](https://adventofcode.com/2015/day/15) | **Graph**: None | **CS**: Constraint optimization

## Approach
4 ingredients must sum to 100 teaspoons. UNWIND all combinations where `a + b + c + d = 100` (using 3 nested ranges, d = 100-a-b-c). Compute score as product of property sums (clamped to 0). Part 2: additionally filter for exactly 500 calories.

## Answers
| Part | Answer |
|------|--------|
| 1 | 222870 |
| 2 | 117936 |

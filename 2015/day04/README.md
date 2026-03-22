# Day 4: The Ideal Stocking Stuffer
[Problem](https://adventofcode.com/2015/day/4) | **Graph**: None | **CS**: Hash mining (MD5)

## Approach
Iterate N from 1 upward, compute `apoc.util.md5([key + N])`, check if result starts with 5 (P1) or 6 (P2) zeros. Uses `reduce()` with early termination.

## Answers
| Part | Answer |
|------|--------|
| 1 | 117946 |
| 2 | 3938038 |

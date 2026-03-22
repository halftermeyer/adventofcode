# Day 11: Corporate Policy
[Problem](https://adventofcode.com/2015/day/11) | **Graph**: None | **CS**: Constrained search

## Approach
Increment password character-by-character using `reduce()` over char codes (a=97..z=122) with carry propagation. Validate: must contain a straight of 3 consecutive letters, no `i`/`o`/`l`, and two different non-overlapping pairs. Repeat until valid password found. Part 2: increment once more and find next valid.

## Answers
| Part | Answer |
|------|--------|
| 1 | hepxxyzz |
| 2 | heqaabcc |

# Day 1: Not Quite Lisp
[Problem](https://adventofcode.com/2015/day/1) | **Graph**: None | **CS**: Fold/accumulate

## Approach
Simple fold: `(` = +1, `)` = -1. Part 1: final sum. Part 2: position where sum first reaches -1. Both in single `reduce()` with early termination flag for Part 2.

## Answers
| Part | Answer |
|------|--------|
| 1 | 138 |
| 2 | 1771 |

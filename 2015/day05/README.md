# Day 5: Doesn't He Have Intern-Elves For This?
[Problem](https://adventofcode.com/2015/day/5) | **Graph**: None | **CS**: String validation / regex

## Approach
Part 1: 3+ vowels, double letter, no forbidden substrings. Part 2: non-overlapping pair + sandwich letter. All via list comprehension with `any()`, `split()` for pair detection.

## Answers
| Part | Answer |
|------|--------|
| 1 | 236 |
| 2 | 51 |

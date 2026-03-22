# Day 10: Elves Look, Elves Say
[Problem](https://adventofcode.com/2015/day/10) | **Graph**: None | **CS**: Run-length encoding

## Approach
String-based RLE: each iteration uses `reduce()` to walk the string char-by-char, building runs, then concatenate counts+chars. 40 iterations (P1) produces 252K chars, 50 iterations (P2) produces 3.58M chars.

## Answers
| Part | Answer |
|------|--------|
| 1 | 252594 |
| 2 | 3579328 |

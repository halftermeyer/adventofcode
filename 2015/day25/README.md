# Day 25: Let It Snow
[Problem](https://adventofcode.com/2015/day/25) | **Graph**: None | **CS**: Modular exponentiation

## Approach
The code grid fills diagonally. Given row and column from input, compute the linear index via triangular number formula: `idx = (diag*(diag-1))/2 + col` where `diag = row + col - 1`. Then compute `20151125 * 252533^(idx-1) mod 33554393` using `reduce()` square-and-multiply for modular exponentiation.

## Answers
| Part | Answer |
|------|--------|
| 1 | 19980801 |
| 2 | -- |

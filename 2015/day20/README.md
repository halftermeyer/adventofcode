# Day 20: Infinite Elves and Infinite Houses
[Problem](https://adventofcode.com/2015/day/20) | **Graph**: None | **CS**: Number theory (divisor sum)

## Approach
For each house number, compute the sum of its divisors using `sqrt()` optimization (check divisors up to sqrt(n), add both d and n/d). Part 1: presents = 10 * divisor_sum. Part 2: each elf stops after 50 houses, so only count divisor d if n/d <= 50, presents = 11 * filtered_sum. Find lowest house meeting the target.

## Answers
| Part | Answer |
|------|--------|
| 1 | 786240 |
| 2 | 705600 |

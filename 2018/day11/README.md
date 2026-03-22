# Day 11: Chronal Charge

[Problem](https://adventofcode.com/2018/day/11)

## Problem Summary

300x300 grid of fuel cells. Power level formula based on serial number.

- **Part 1**: Find 3x3 square with highest total power. Return top-left X,Y.
- **Part 2**: Find NxN square (any size) with highest power. Return X,Y,N.

## Approach

### Part 1
Compute full 300x300 grid via nested list comprehension, then scan all 298x298 possible 3x3 squares with direct index access.

### Part 2
Build row prefix sums for O(1) row-range queries. For each square size 1-30, compute all squares using prefix sums. The answer typically falls within size 1-30 for most inputs.

## Answers

| Part | Answer |
|------|--------|
| 1 | **33,54** |
| 2 | **232,289,8** |

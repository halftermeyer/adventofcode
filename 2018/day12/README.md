# Day 12: Subterranean Sustainability

[Problem](https://adventofcode.com/2018/day/12)

## Problem Summary

Cellular automaton on a 1D row of pots. Rules determine which pots have plants next generation.

- **Part 1**: Sum of pot numbers with plants after 20 generations.
- **Part 2**: Same after 50 billion generations.

## Approach

### Part 1
Represent state as list of pot indices. Each generation: check each pot ±2 against rule set, produce new list. 20 iterations via `reduce()`.

### Part 2
Run until the sum delta stabilizes (same delta for 5+ consecutive generations). At generation 121, delta stabilizes at 55. Extrapolate: `sum_at_121 + (50B - 121) * 55`.

## Answers

| Part | Answer |
|------|--------|
| 1 | **3241** |
| 2 | **2749999999911** |

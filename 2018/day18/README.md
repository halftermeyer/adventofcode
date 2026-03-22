# Day 18: Settlers of The North Pole

[Problem](https://adventofcode.com/2018/day/18)

## Problem Summary

50x50 grid cellular automaton. Open(.) → Trees(|) if 3+ adjacent trees. Trees → Lumber(#) if 3+ adjacent lumber. Lumber → Open unless adjacent to both lumber and trees.

- **Part 1**: Resource value (trees * lumber) after 10 minutes.
- **Part 2**: Resource value after 1 billion minutes.

## Approach

Flatten grid to 1D list. Each step: for each cell, count 8-neighbors by type, apply rules. All via `reduce()` over minutes.

### Part 2
Run until cycle detected in resource values (detected at minute ~100, cycle length 21). Extrapolate to 1 billion.

## Answers

| Part | Answer |
|------|--------|
| 1 | **675100** |
| 2 | **115884** |

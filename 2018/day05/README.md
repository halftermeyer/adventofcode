# Day 5: Alchemical Reduction

[Problem](https://adventofcode.com/2018/day/5)

## Problem Summary

Polymer reduction: adjacent units of same letter but opposite case (e.g. `aA`, `Bb`) annihilate. Repeat until stable.

- **Part 1**: How many units remain after full reduction?
- **Part 2**: Remove all instances of one letter (both cases), reduce, find which letter removal yields shortest polymer.

## Approach

**Stack machine** via `reduce()` — the classic pattern for this problem. Push each character; if top of stack reacts with current char (same letter, different case), pop instead of pushing.

### Part 1
Single pass stack reduction.

### Part 2
For each letter a-z: filter it out from input, then run the same stack reduction. Return the minimum result.

## Answers

| Part | Answer |
|------|--------|
| 1 | **10888** |
| 2 | **6952** |

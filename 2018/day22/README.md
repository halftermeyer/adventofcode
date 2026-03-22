# Day 22: Mode Maze

[Problem](https://adventofcode.com/2018/day/22)

## Problem Summary

Cave grid with erosion levels. Each cell type (rocky/wet/narrow) determined by geologic index formula.

- **Part 1**: Sum of risk levels in rectangle from (0,0) to target.
- **Part 2**: Shortest path to target with tool-switching constraints (skipped — requires state-space graph).

## Approach

### Part 1
Build erosion level grid as flat array via `reduce()`. Each cell computed from depth + geologic index. Geologic index depends on previous cells (left and above), so the flat array with `arr[pos-1]` and `arr[pos-w]` gives O(1) access to dependencies.

Formula: `erosion = (geo_index + depth) % 20183`, risk = `erosion % 3`.

### Part 2
Requires building a state-space graph (position + current tool) and finding shortest path with tool-switch penalties. Skipped — would need graph nodes for (x, y, tool) states.

## Answers

| Part | Answer |
|------|--------|
| 1 | **10603** |
| 2 | Skipped (state-space graph needed) |

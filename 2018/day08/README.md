# Day 8: Memory Maneuver

[Problem](https://adventofcode.com/2018/day/8)

## Problem Summary

Parse a tree from a flat list of numbers. Each node: header (num_children, num_metadata), then children, then metadata entries.

- **Part 1**: Sum of all metadata entries across all nodes.
- **Part 2**: Value of root node. Leaf value = sum(metadata). Internal value = sum of values of children indexed by metadata (1-based, skip out-of-range).

## Approach

Stack-based parser via `reduce()`. States: `header` (read num_children + num_meta) and `meta` (read metadata). For leaf nodes (0 children), process metadata immediately. For internal nodes, push onto stack, process children first. When all children done, read parent's metadata and compute value.

18,992 numbers parsed in a single `reduce()` pass — showcases CYPHER 25's ability to handle complex recursive data structures without graph writes.

## Answers

| Part | Answer |
|------|--------|
| 1 | **49180** |
| 2 | **20611** |

# Day 13: Distress Signal
[Problem](https://adventofcode.com/2022/day/13) | **Graph**: Tree (Packet hierarchy) | **CS**: Recursive comparison

## Graph Model
`(:Packet)` and `(:Element)` nodes forming nested trees via `[:CONTAINS]` relationships. Each element is either an integer leaf or a list sub-tree with ordered children.

## Approach
Parse nested bracket notation into tree structures where each list becomes a parent node with ordered children. Implement the recursive comparison rules (integer vs integer, list vs list, mixed) by traversing paired trees. Part 1 sums indices of correctly ordered pairs; Part 2 inserts divider packets and sorts.

## Key Techniques
- Nested list parsing into tree structures
- Recursive pairwise comparison via tree traversal
- Sorting with custom comparator for Part 2

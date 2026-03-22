# Day 9: Marble Mania

[Problem](https://adventofcode.com/2018/day/9)

## Problem Summary

Marble circle game. Insert marbles into a circle following rules. Multiples of 23 are special (remove marble 7 positions CCW, add both to score).

- **Part 1**: 431 players, last marble 70950. Highest score?
- **Part 2**: Same but last marble 7095000.

## Approach

This problem requires O(1) insert/remove in a circular list. Cypher lists are O(n) for mid-list operations, making this O(n^2) total — impractical for Part 1 (70K marbles) and impossible for Part 2 (7M marbles).

**Skipped** — this is one of the few AoC problems fundamentally incompatible with Cypher's data structures. Would need a doubly-linked list as graph nodes with CW/CCW relationships and 70K+ individual transactions.

## Status

| Part | Status |
|------|--------|
| 1 | Skipped (O(n^2) list operations) |
| 2 | Skipped (7M marbles impossible) |

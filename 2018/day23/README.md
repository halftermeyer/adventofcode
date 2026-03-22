# Day 23: Experimental Emergency Teleportation

[Problem](https://adventofcode.com/2018/day/23)

## Problem Summary

1000 nanobots with 3D positions and signal radii (Manhattan distance).

- **Part 1**: Find nanobot with largest radius. How many bots in its range?
- **Part 2**: Find point in range of most nanobots (NP-hard in general).

## Approach

### Part 1
Pure functional: find bot with max radius, count bots within its Manhattan distance.

### Part 2
Skipped — this is an optimization problem (NP-hard) that typically requires binary search on octahedra or Z3 SMT solver. Not well-suited to Cypher.

## Answers

| Part | Answer |
|------|--------|
| 1 | **408** |
| 2 | Skipped (NP-hard optimization) |

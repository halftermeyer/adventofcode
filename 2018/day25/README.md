# Day 25: Four-Dimensional Adventure

[Problem](https://adventofcode.com/2018/day/25)

## Problem Summary

1248 points in 4D space. Points within Manhattan distance 3 form constellations (connected components).

- **Part 1**: How many constellations?

## Approach

Union-find via `reduce()`: for each pair of points within distance 3, merge their components. Chase pointers to find roots, count distinct.

Alternatively could build a graph with `:NEAR` relationships and use GDS WCC, but the functional approach works well for 1248 points.

## Answers

| Part | Answer |
|------|--------|
| 1 | **386** |

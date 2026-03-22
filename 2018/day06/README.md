# Day 6: Chronal Coordinates

[Problem](https://adventofcode.com/2018/day/6)

## Problem Summary

Given a set of coordinates, compute Manhattan distance Voronoi regions.

- **Part 1**: Size of the largest finite region.
- **Part 2**: Count of locations with total Manhattan distance to all coordinates < 10000.

## Approach

Parse coordinates, compute bounding box. For each grid point, compute distance to all coordinates. Part 1: assign to closest (ties = no owner), exclude infinite regions (those touching border). Part 2: sum all distances per point, count those under threshold.

Both parts solved in a single query using UNWIND over the grid with CYPHER 25.

## Answers

| Part | Answer |
|------|--------|
| 1 | **4284** |
| 2 | **35490** |

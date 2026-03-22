# Day 20: A Regular Map

[Problem](https://adventofcode.com/2018/day/20)

## Problem Summary

A regex describes paths through a facility. Build the map, find farthest room.

- **Part 1**: Shortest path to the farthest room (most doors).
- **Part 2**: How many rooms have shortest path >= 1000 doors?

## Approach

This is a **natural graph problem**!

1. Parse regex with `reduce()` + stack for branching: `(` pushes position, `|` resets to branch point, `)` pops
2. Create `:Room` nodes and `:DOOR` relationships as we walk
3. Use native `shortestPath()` from origin to all rooms
4. Part 1: max distance. Part 2: count rooms with distance >= 1000.

## Answers

| Part | Answer |
|------|--------|
| 1 | **3560** |
| 2 | **8688** |

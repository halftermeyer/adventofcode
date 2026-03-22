# Day 10: The Stars Align

[Problem](https://adventofcode.com/2018/day/10)

## Problem Summary

Points with positions and velocities. Find the time when they align to form a message.

- **Part 1**: What message appears?
- **Part 2**: How many seconds until the message appears?

## Approach

1. Preprocess input to extract 4 numbers per line (px, py, vx, vy)
2. Coarse search: compute bounding box height at t=0,100,200,...,20000
3. Fine search: ±100 around the best coarse time
4. Render the message at the optimal time using list comprehension

All done in pure CYPHER 25 with two NEXT stages.

## Answers

| Part | Answer |
|------|--------|
| 1 | **FNRGPBHR** |
| 2 | **10511** |

# Day 9: Rope Bridge
[Problem](https://adventofcode.com/2022/day/9) | **Graph**: Coordinate Grid (Position nodes) | **CS**: Physical simulation

## Graph Model
`(:Position)` nodes representing grid coordinates visited by the rope knots. Movement instructions are processed sequentially to update head and tail positions.

## Approach
Track head and tail positions on a coordinate grid. For each head movement, apply distance-based rules to determine if and how the tail follows. Part 1 uses a 2-knot rope; Part 2 extends to 10 knots, propagating movement through the chain. Count distinct positions visited by the tail.

## Key Techniques
- Coordinate-based position tracking
- Chebyshev distance for tail movement rules
- Chain propagation for multi-knot simulation (Part 2)

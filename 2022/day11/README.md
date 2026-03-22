# Day 11: Monkey in the Middle
[Problem](https://adventofcode.com/2022/day/11) | **Graph**: Monkey network | **CS**: Simulation with modular arithmetic

## Graph Model
`(:Monkey)` nodes with `[:THROWS_TRUE]` and `[:THROWS_FALSE]` relationships encoding the divisibility test routing. Each monkey stores its operation and divisor.

## Approach
Build a monkey network where throw targets are encoded as relationships. Simulate rounds by processing each monkey's items, applying the worry operation, testing divisibility, and routing items via the appropriate throw relationship. Part 1 divides worry by 3; Part 2 uses the LCM of all divisors to keep values manageable.

## Key Techniques
- Graph-encoded throw routing logic
- Iterative round simulation
- Modular arithmetic (LCM) for Part 2 worry management

# Day 10: Cathode Ray Tube
[Problem](https://adventofcode.com/2022/day/10) | **Graph**: Linked List (Instruction chain) | **CS**: CPU simulation

## Graph Model
`(:Instruction)` nodes linked by `[:NEXT]` relationships forming an execution chain. Each instruction stores its type (noop/addx), cycle count, and the resulting X register value.

## Approach
Build an instruction chain as a linked list. Propagate cycle numbers and X register state along the chain using `apoc.periodic.commit`. Part 1 samples signal strength at specific cycles; Part 2 renders a CRT display by comparing sprite position (X) with pixel position (cycle mod 40).

## Key Techniques
- Linked list instruction chain with state propagation
- `apoc.periodic.commit` for iterative state updates
- CRT pixel rendering via modular arithmetic

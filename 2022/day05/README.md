# Day 5: Supply Stacks
[Problem](https://adventofcode.com/2022/day/5) | **Graph**: Linked List (Stack/Crate nodes) | **CS**: Stack simulation

## Graph Model
`(:Stack)` nodes as stack heads, `(:Crate)` nodes linked by `[:NEXT]` relationships forming linked lists. Each stack points to its top crate.

## Approach
Build stacks as linked lists with NEXT relationships connecting crate nodes. Execute move operations by relinking nodes: Part 1 moves crates one at a time (reversing order), Part 2 moves them as a group (preserving order). Read the top of each stack at the end.

## Key Techniques
- Linked list representation of stacks
- Pointer manipulation (delete/create NEXT rels) for move operations
- LIFO vs FIFO move semantics for Part 1 vs Part 2

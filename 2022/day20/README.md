# Day 20: Grove Positioning
[Problem](https://adventofcode.com/2022/day/20) | **Graph**: Circular Linked List (Number + PosToken) | **CS**: Modular arithmetic in linked lists

## Graph Model
`(:Number)` nodes holding values and `(:PosToken)` nodes representing positions in the circular list, linked by `[:NEXT]` relationships. Numbers are associated with position tokens to allow independent movement.

## Approach
Build a circular linked list with position tokens. For each number, compute its effective move distance using modulo (list length - 1), then relink the token to its new position by splicing it out and inserting it at the target. Part 2 multiplies values by the decryption key and mixes 10 times.

## Key Techniques
- Circular linked list with position token indirection
- Modular arithmetic for wrap-around movement
- Pointer manipulation (splice out, insert at target)

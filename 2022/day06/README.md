# Day 6: Tuning Trouble
[Problem](https://adventofcode.com/2022/day/6) | **Graph**: Linked List (Character chain) | **CS**: Sliding window uniqueness

## Graph Model
`(:Character)` nodes linked by `[:NEXT]` relationships forming a sequence chain. Each node stores its character value and position index.

## Approach
Build the input string as a linked list of character nodes. Slide a window of size 4 (Part 1) or 14 (Part 2) along the chain and check if all characters in the window are distinct. Return the position of the first window satisfying uniqueness.

## Key Techniques
- Character-level linked list construction
- Sliding window via variable-length path traversal
- Uniqueness check on collected window elements

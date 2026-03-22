# Day 10: Knot Hash
[Problem](https://adventofcode.com/2017/day/10) | **Graph**: None | **CS**: Circular list reversal + XOR hash
## Approach
Maintain a circular list of 256 elements. For each length, reverse that many elements starting at current position, advance position by length + skip size. Part 1: one round, multiply first two elements. Part 2: 64 rounds with ASCII input + suffix, XOR each block of 16 into dense hash, convert to hex.
## Answers
| Part | Answer |
|------|--------|
| 1 | 54675 |
| 2 | a7af2706aa9a09cf5d848c1e6605dd2a |

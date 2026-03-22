# Day 9: Explosives in Cyberspace
[Problem](https://adventofcode.com/2016/day/9) | **Graph**: None | **CS**: Recursive decompression / multiplier stack
## Approach
Part 1: single-pass decompression, parsing (NxM) markers and skipping over the taken characters. Part 2: multiplier stack approach -- when a marker is encountered, push its repeat count onto the stack; each plain character contributes the product of all active multipliers.
## Answers
| Part | Answer |
|------|--------|
| 1 | 112830 |
| 2 | 10931789799 |

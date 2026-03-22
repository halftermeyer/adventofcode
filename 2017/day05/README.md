# Day 5: Twisty Trampolines
[Problem](https://adventofcode.com/2017/day/5) | **Graph**: None | **CS**: Jump list VM
## Approach
Maintain a list of jump offsets. Each step: read offset at current position, increment it, jump. Count steps until exiting the list. Part 1 only (Part 2 requires too many iterations for pure Cypher).
## Answers
| Part | Answer |
|------|--------|
| 1 | 343364 |
| 2 | — |

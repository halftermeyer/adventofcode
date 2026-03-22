# Day 25: Clock Signal
[Problem](https://adventofcode.com/2016/day/25) | **Graph**: None | **CS**: VM + output validation
## Approach
Extended assembunny VM with 'out' instruction. Try successive values of register a (0..1000), run VM collecting output, check if output matches alternating 0,1,0,1,... pattern. Return first valid a.
## Answers
| Part | Answer |
|------|--------|
| 1 | 196 |
| 2 | — |

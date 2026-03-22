# Day 14: Reindeer Olympics
[Problem](https://adventofcode.com/2015/day/14) | **Graph**: None | **CS**: Simulation

## Approach
Parse reindeer stats (speed, fly-time, rest-time). Part 1: compute distance at t=2503 using modular arithmetic (full cycles + partial). Part 2: simulate second-by-second for 2503 seconds, awarding 1 point to the leader each second via `reduce()`.

## Answers
| Part | Answer |
|------|--------|
| 1 | 2640 |
| 2 | 1102 |

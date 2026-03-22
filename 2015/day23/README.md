# Day 23: Opening the Turing Lock
[Problem](https://adventofcode.com/2015/day/23) | **Graph**: None | **CS**: VM / interpreter

## Approach
Simulate a register machine with registers `a` and `b` and instruction pointer `ip`. Instructions: `hlf r` (halve), `tpl r` (triple), `inc r` (increment), `jmp offset`, `jie r,offset` (jump if even), `jio r,offset` (jump if one). Execute via `reduce()` with state `{a, b, ip}` until `ip` is out of bounds. Part 1: a=0 initially. Part 2: a=1 initially.

## Answers
| Part | Answer |
|------|--------|
| 1 | 184 |
| 2 | 231 |

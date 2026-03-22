# Day 7: The Sum of Its Parts

[Problem](https://adventofcode.com/2018/day/7)

## Problem Summary

Steps with dependencies. Format: "Step C must be finished before step A can begin."

- **Part 1**: Complete steps in order (alphabetical when tied).
- **Part 2**: With 5 workers and step duration 60+position(A=1..Z=26), how many seconds?

## Approach

### Part 1
Topological sort via reduce: each iteration finds all ready steps (dependencies met), picks alphabetically first. Uses `coll.sort()` for ordering.

### Part 2
Simulate tick by tick. State = `{time, done, wip: [{step, finish_time}], remaining}`. Each iteration advances to the next finish time, completes tasks, assigns new ready tasks to free workers. Uses nested `head()` bindings for intermediate values.

## Answers

| Part | Answer |
|------|--------|
| 1 | **BCADPVTJFZNRWXHEKSQLUYGMIO** |
| 2 | **973** |

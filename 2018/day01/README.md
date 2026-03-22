# Day 1: Chronal Calibration

[Problem](https://adventofcode.com/2018/day/1)

## Problem Summary

A device needs frequency calibration. Starting at frequency 0, apply a list of integer changes (`+1`, `-2`, `+3`, ...).

- **Part 1**: What is the resulting frequency after all changes are applied?
- **Part 2**: What is the first frequency reached **twice**? The list of changes repeats cyclically until a duplicate is found.

## Examples

```
Input: +1, -2, +3, +1

Part 1: 0 → 1 → -1 → 2 → 3  ⟹  answer: 3

Part 2 examples:
  +1, -1         → first repeated freq: 0  (cycle: 0, 1, 0 ✓)
  +3, +3, +4, -2, -4 → first repeated freq: 10
  -6, +3, +8, +5, -6 → first repeated freq: 5
  +7, +7, -2, -7, -4 → first repeated freq: 14
```

## Approach

**No graph structure needed** — this is purely computational. Both parts use `LET` + `reduce()` in a CYPHER 25 functional pipeline.

### Part 1

Simple fold: accumulate the sum of all changes.

```cypher
reduce(freq = 0, c IN changes | freq + c)
```

### Part 2

Repeat the change list 200 times (enough for convergence), then fold with a state object tracking:
- `freq` — current frequency
- `seen` — list of all frequencies visited so far
- `found` — early termination flag
- `answer` — the first duplicate

The `head()` trick binds `new_freq` inside the `reduce` body (since `LET` is not available inside `reduce`):

```cypher
head([new_freq IN [s.freq + c] |
  CASE WHEN new_freq IN s.seen
    THEN {freq: new_freq, found: true, answer: new_freq, seen: s.seen}
    ELSE {freq: new_freq, found: false, answer: 0, seen: s.seen + [new_freq]}
  END
])
```

Once `found` is `true`, all remaining iterations short-circuit via `CASE WHEN s.found THEN s`.

## Answers

| Part | Answer |
|------|--------|
| 1 | **477** |
| 2 | **390** |

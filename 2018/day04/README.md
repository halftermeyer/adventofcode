# Day 4: Repose Record

[Problem](https://adventofcode.com/2018/day/4)

## Problem Summary

Guard sleep logs. Parse timestamps, track which guard is on duty, when they sleep/wake.

- **Part 1** (Strategy 1): Find guard with most total sleep minutes. Answer = guard_id * their most-slept minute.
- **Part 2** (Strategy 2): Find guard most frequently asleep on a single minute. Answer = guard_id * that minute.

## Approach

1. Sort lines lexicographically (ISO timestamps sort correctly)
2. `reduce()` to parse events, tracking current guard ID
3. Pair consecutive sleep/wake events into intervals
4. UNWIND intervals into individual minutes
5. Aggregate by guard + minute

### Part 1
Group by guard, sum total sleep, take top guard, find their top minute.

### Part 2
Group by (guard, minute), take the single highest count.

## Answers

| Part | Answer |
|------|--------|
| 1 | **85296** |
| 2 | **58559** |

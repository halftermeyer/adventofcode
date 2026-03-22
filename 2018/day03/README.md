# Day 3: No Matter How You Slice It

[Problem](https://adventofcode.com/2018/day/3)

## Problem Summary

Fabric claims in format `#ID @ left,top: widthxheight` on a shared piece of fabric.

- **Part 1**: How many square inches are claimed by 2+ claims?
- **Part 2**: Which claim doesn't overlap with any other?

## Approach

### Part 1
Parse claims into `{id, l, t, r, b}` rectangles. UNWIND each claim's squares (x,y), group by position, count positions with 2+ claims.

### Part 2
Pairwise rectangle overlap check (no grid expansion needed). Two rectangles overlap if `a.l < b.r AND b.l < a.r AND a.t < b.b AND b.t < a.b`. Collect all IDs involved in any overlap, return the one not in that set. Uses `coll.distinct()` to deduplicate.

## Answers

| Part | Answer |
|------|--------|
| 1 | **105231** |
| 2 | **164** |

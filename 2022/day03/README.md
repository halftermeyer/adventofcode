# Day 3: Rucksack Reorganization
[Problem](https://adventofcode.com/2022/day/3) | **Graph**: None | **CS**: Set intersection

## Graph Model
None — pure functional. Strings are split into character collections and intersected.

## Approach
Split each rucksack string into two halves and find the common character using collection filtering. For Part 2, group rucksacks into triples and find the character common to all three. Character priorities are computed from ASCII values.

## Key Techniques
- String splitting with `substring` and `size`
- Collection intersection via list filtering
- ASCII-based priority calculation

# Day 16: Chronal Classification

[Problem](https://adventofcode.com/2018/day/16)

## Problem Summary

16-opcode VM with unknown opcode mapping. Input has two sections: sample before/after register states with instructions, then a program.

- **Part 1**: How many samples match 3+ opcodes?
- **Part 2**: Determine the opcode mapping, run the program, what's in register 0?

## Approach

### Part 1
For each sample, test all 16 opcode implementations against the before/after registers. Count samples where 3+ opcodes produce the correct output. Includes bitwise AND/OR via bit decomposition (Cypher has no native bitwise ops).

### Part 2
1. For each opcode number, intersect all possible mappings across all samples
2. Iteratively resolve: opcodes with 1 candidate are fixed, remove that candidate from all others
3. Run the program with the resolved mapping via `reduce()` over instructions

### Bitwise AND/OR in Cypher
Since Cypher lacks native bitwise operators, AND and OR are implemented via:
```cypher
reduce(s = 0, bit IN [0..15] |
  s + CASE WHEN (a / powers[bit]) % 2 = 1 AND (b / powers[bit]) % 2 = 1
    THEN powers[bit] ELSE 0 END
)
```

## Answers

| Part | Answer |
|------|--------|
| 1 | **676** |
| 2 | **584** |

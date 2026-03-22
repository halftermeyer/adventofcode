# Day 2: Inventory Management System

[Problem](https://adventofcode.com/2018/day/2)

## Problem Summary

- **Part 1**: Count box IDs containing any letter exactly twice, count those with exactly three, multiply.
- **Part 2**: Find two box IDs differing by exactly one character at the same position. Return the common characters.

## Approach

Pure functional CYPHER 25. No graph writes.

### Part 1
For each ID, check if `any(ch IN split(id,'') WHERE size([c ... WHERE c=ch]) = 2)`. Count IDs matching "has two" and "has three", multiply.

### Part 2
UNWIND all pairs (i < j), filter to those with exactly 1 differing position, extract common chars via reduce.

## Answers

| Part | Answer |
|------|--------|
| 1 | **7350** |
| 2 | **wmlnjevbfodamyiqpucrhsukg** |

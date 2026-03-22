# Day 4: Security Through Obscurity
[Problem](https://adventofcode.com/2016/day/4) | **Graph**: None | **CS**: Frequency analysis + Caesar cipher
## Approach
Parse room names, sector IDs, and checksums. Validate by computing top-5 most frequent letters (alphabetical tiebreak). Part 1: sum valid sector IDs. Part 2: Caesar-shift each letter by sector ID, find "northpole" room.
## Answers
| Part | Answer |
|------|--------|
| 1 | 409147 |
| 2 | 991 |

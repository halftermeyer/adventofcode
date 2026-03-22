# Day 1: No Time for a Taxicab
[Problem](https://adventofcode.com/2016/day/1) | **Graph**: None | **CS**: Grid walk + set intersection
## Approach
reduce() with direction state (0=N,1=E,2=S,3=W). Part 1: final Manhattan distance. Part 2: nested reduce() expanding each move into individual steps, tracking visited positions.
## Answers
| Part | Answer |
|------|--------|
| 1 | 226 |
| 2 | 79 |

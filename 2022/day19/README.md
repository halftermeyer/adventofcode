# Day 19: Not Enough Minerals
[Problem](https://adventofcode.com/2022/day/19) | **Graph**: State Graph | **CS**: Bounded BFS with pruning

## Graph Model
Implicit state graph where each state encodes the current time, robot counts, and resource counts. States are explored via BFS with aggressive pruning.

## Approach
For each blueprint, explore the state space of build decisions (which robot to build next) within a time budget. Apply greedy heuristics and upper-bound pruning to keep the search tractable. Part 1 uses 24 minutes across all blueprints; Part 2 uses 32 minutes on the first three.

## Key Techniques
- State space BFS with resource/robot tracking
- Greedy pruning (e.g., skip building if already producing enough)
- Upper-bound estimation to prune unpromising branches

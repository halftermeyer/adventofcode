# Day 16: Proboscidea Volcanium
[Problem](https://adventofcode.com/2022/day/16) | **Graph**: Weighted Network (Valve nodes) | **CS**: All-pairs shortest paths + state search

## Graph Model
`(:Valve)` nodes with `flow_rate` properties, connected by `[:TUNNEL]` relationships. Precomputed `[:DIST]` relationships store shortest distances between all non-zero-flow valves.

## Approach
Parse the valve network and compute all-pairs shortest paths using Floyd-Warshall. Then explore the state space of which valves to open in which order within the 30-minute budget, maximizing total pressure released. Part 2 splits the work between you and the elephant, partitioning the valve set.

## Key Techniques
- Floyd-Warshall for all-pairs shortest paths
- State space exploration with time-budget pruning
- Valve set partitioning for two-agent optimization (Part 2)

# Day 2: Rock Paper Scissors
[Problem](https://adventofcode.com/2022/day/2) | **Graph**: Gesture graph | **CS**: Game logic as graph traversal

## Graph Model
`(:Gesture)` nodes (Rock, Paper, Scissors) connected by `[:BEATS]` relationships forming a directed cycle. Each gesture also has a self-loop `[:DRAWS]`.

## Approach
Model the win/lose/draw rules as directed relationships between gesture nodes. For each round, traverse the graph to determine the outcome and compute the score. Part 2 reverses the lookup: given the desired outcome, find the required gesture.

## Key Techniques
- Directed cycle graph for game rules
- Relationship traversal to determine round outcomes
- Reverse graph lookup for Part 2 strategy decoding

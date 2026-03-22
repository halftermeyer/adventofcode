# Day 7: No Space Left On Device
[Problem](https://adventofcode.com/2022/day/7) | **Graph**: Tree (Directory hierarchy) | **CS**: Tree traversal

## Graph Model
`(:Dir)` and `(:File)` nodes connected by `[:CONTAINS]` relationships forming a filesystem tree. The root is `/`. Each file has a `size` property.

## Approach
Build a directory tree from the terminal output (cd/ls commands). Compute directory sizes bottom-up by iteratively propagating file sizes from leaves to ancestors. Part 1 sums directories with size at most 100000; Part 2 finds the smallest directory to delete to free enough space.

## Key Techniques
- Tree construction from command parsing
- Bottom-up size propagation via iterative traversal
- Threshold filtering and minimum selection

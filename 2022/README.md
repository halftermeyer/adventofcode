# Advent of Code 2022 in Cypher — 50 Stars

The crown jewel: all 25 days solved in pure Cypher with APOC and GDS on Neo4j 5. Proof that **Cypher is AoC-complete**.

Original repo: [github.com/halftermeyer/AoC-2022-cypher](https://github.com/halftermeyer/AoC-2022-cypher)

| Day | Puzzle | Graph Type | CS Concept | Approach |
|-----|--------|-----------|------------|----------|
| 1 | Calorie Counting | None | Aggregation | LOAD CSV + sum + LIMIT |
| 2 | Rock Paper Scissors | Gesture graph | Game rules as relationships | Directed beats graph |
| 3 | Rucksack Reorganization | None | Set intersection | Collection operations |
| 4 | Camp Cleanup | None | Range overlap | Boolean range comparison |
| 5 | Supply Stacks | Linked List | Stack LIFO/FIFO | Stack nodes with NEXT rels |
| 6 | Tuning Trouble | Linked List | Sliding window | Character chain uniqueness |
| 7 | No Space Left On Device | Tree | Tree traversal | Directory hierarchy, bottom-up size |
| 8 | Treetop Tree House | Grid Graph | Visibility analysis | Directional neighbor links, horizon heights |
| 9 | Rope Bridge | Coordinate Grid | Physical simulation | Position tracking, distance-based tail movement |
| 10 | Cathode Ray Tube | Linked List | CPU simulation | Instruction chain, state propagation |
| 11 | Monkey in the Middle | Graph | Simulation | Monkey network with throw relationships |
| 12 | Hill Climbing | Grid Graph + GDS | Dijkstra shortest path | Elevation-filtered edges, GDS Dijkstra |
| 13 | Distress Signal | Tree | Recursive comparison | Nested packet tree, pairwise comparison |
| 14 | Regolith Reservoir | Grid Graph | Sand simulation | Priority-weighted FALLS relationships |
| 15 | Beacon Exclusion Zone | None | Interval merging | Sensor-beacon coverage intervals |
| 16 | Proboscidea Volcanium | Weighted Network | APSP + state search | Floyd-Warshall, state space exploration |
| 17 | Pyroclastic Flow | Grid Graph | Falling blocks | Pixel nodes, jet pattern simulation |
| 18 | Boiling Boulders | 3D Grid | Connected components / flood fill | 3D cube adjacency, external surface BFS |
| 19 | Not Enough Minerals | State Graph | Bounded BFS | Blueprint state space, greedy pruning |
| 20 | Grove Positioning | Circular Linked List | Modular arithmetic | PosToken circular list, pointer manipulation |
| 21 | Monkey Math | Expression Tree | Equation solving | Forward eval + back-propagation |
| 22 | Monkey Map | Toroidal Grid | 2D navigation / cube mapping | Grid with wrapping, cube face directions |
| 23 | Unstable Diffusion | Coordinate Grid | Multi-agent simulation | Elf movement with conflict resolution |
| 24 | Blizzard Basin | Space-Time Graph + GDS | Dijkstra in 4D | Position×time nodes, modular blizzard dynamics |
| 25 | Full of Hot Air | None | Base conversion | SNAFU (balanced base-5) encoding |

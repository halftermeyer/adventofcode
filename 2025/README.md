# Advent of Code 2025 in CYPHER 25

12 days solved in pure CYPHER 25. No Python, no JavaScript -- the database does everything.

Original repo: [github.com/halftermeyer/AoC-2025](https://github.com/halftermeyer/AoC-2025)

Blog series: [medium.com/@pierre.halftermeyer](https://medium.com/@pierre.halftermeyer)

| Day | Puzzle | Graph Type | CS Concept | Cypher Highlights |
|-----|--------|-----------|------------|-------------------|
| 1 | Secret Entrance | None | Modular arithmetic | Stateful `reduce()`, `LET` |
| 2 | Gift Shop | None | Range enumeration | Nested `reduce()`, `NEXT` |
| 3 | Lobby | None | Greedy selection | Suffix scanning |
| 4 | Printing Department | Grid Graph | K-core / degree removal | `IN TRANSACTIONS ON ERROR BREAK`, GDS k-core |
| 5 | Cafeteria | Overlap Graph | Interval union / WCC | `WHEN`, iterative merging, GDS WCC |
| 6 | Trash Compactor | None | Stack-based evaluation | `reduce()` as stack machine |
| 7 | Laboratories | DAG | Beam propagation | Directional edges, property propagation |
| 8 | Playground | 3D Point Cloud | Union-find forest | `SAME_CC_AS` variable-length paths, spatial points |
| 9 | Movie Theater | Polygon Grid | Point-in-polygon (even-odd) | Border chains, parity scans |
| 10 | Factory | State Machine | XOR/ILP, Gaussian elimination | `SHORTEST 1` with predicate, `REPEATABLE ELEMENTS` |
| 11 | Reactor | DAG | Path counting / vertex separators | `CONNECTS_TO` graph, multiplicative shortcuts |
| 12 | Christmas Tree Farm | None | 2D bin packing | Area heuristics, mathematical bounds |

All code is inline in the [main README](https://github.com/halftermeyer/AoC-2025/blob/main/README.md).

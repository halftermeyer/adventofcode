# Advent of Code 2015 in CYPHER 25

| Day | Puzzle | P1 | P2 | Graph Type | CS Concept | Approach |
|-----|--------|----|----|-----------|------------|----------|
| 1 | Not Quite Lisp | 138 | 1771 | None | Fold/accumulate | `reduce()` over parentheses |
| 2 | No Math | 1586300 | 3737498 | None | Optimization | List comprehension + `coll.sort()` |
| 3 | Spherical Houses | 2592 | 2360 | None | Set tracking | `reduce()` with visited-set as list |
| 4 | Ideal Stocking Stuffer | 117946 | 3938038 | None | Hash mining | `reduce()` + `apoc.util.md5()` |
| 5 | Intern-Elves | 236 | 51 | None | String validation | List comprehension with `any()`, regex `=~` |
| 7 | Some Assembly Required | 46065 | 14134 | **DAG** (wire circuit) | Topological evaluation | Iterative wire resolution via `reduce()`, bitwise AND/OR via bit decomposition |
| 9 | All in a Single Night | 117 | 909 | **Weighted Network** | TSP (Hamiltonian path) | `:City`-`:ROAD` graph, explicit 8-city MATCH |
| 10 | Elves Look, Elves Say | 252594 | 3579328 | None | Run-length encoding | `reduce()` RLE producing 3.6M char string |
| 11 | Corporate Policy | hepxxyzz | heqaabcc | None | Constrained search | `reduce()` password increment + validation |
| 12 | JSAbacus | 111754 | — | None | Parsing | `reduce()` char-by-char number extractor |
| 14 | Reindeer Olympics | 2640 | 1102 | None | Simulation | Modular arithmetic + per-second scoring via `reduce()` |
| 15 | Science for Hungry People | 222870 | 117936 | None | Constraint optimization | UNWIND 4-ingredient combos (101³ ≈ 1M) |
| 17 | No Such Thing as Too Much | 1304 | 18 | None | Subset sum | Bitmask enumeration (2²⁰ = 1M subsets) |
| 20 | Infinite Elves | 786240 | 705600 | None | Number theory (divisor sum) | `reduce()` with `sqrt()` divisor sum |
| 23 | Turing Lock | 184 | 231 | None | VM / interpreter | `reduce()` register machine (hlf/tpl/inc/jmp/jie/jio) |
| 25 | Let It Snow | 19980801 | — | None | Modular exponentiation | `reduce()` square-and-multiply |

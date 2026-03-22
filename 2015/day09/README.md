# Day 9: All in a Single Night
[Problem](https://adventofcode.com/2015/day/9) | **Graph**: Weighted Network (cities + roads) | **CS**: TSP (Travelling Salesman)

## Graph Model
```
GRAPH TYPE CityNetwork {
  (City {name STRING})
  (City)-[ROAD {dist INT}]->(City)
}
```

## Approach
Build `:City`-`:ROAD` graph, then MATCH all 8-city Hamiltonian paths via explicit pattern `(c1)-[:ROAD]->(c2)-[:ROAD]->(c3)...` with `WHERE c1 <> c2 AND ...` for uniqueness. 8! = 40320 permutations checked by the query planner.

Part 1: minimum total distance. Part 2: maximum.

## Answers
| Part | Answer |
|------|--------|
| 1 | 117 |
| 2 | 909 |

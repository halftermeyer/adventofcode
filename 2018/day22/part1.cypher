// AoC 2018 Day 22 Part 1 — Mode Maze: sum of risk levels
// Flat array erosion grid via reduce()

CYPHER 25
LET depth = 6084
LET tx = 14
LET ty = 709
LET w = tx + 1
LET total = (ty + 1) * w

LET flat_erosion = reduce(
  arr = [],
  pos IN range(0, total - 1) |
  head([x IN [pos % w] | head([y IN [pos / w] |
    head([geo IN [
      CASE
        WHEN x = 0 AND y = 0 THEN 0
        WHEN x = tx AND y = ty THEN 0
        WHEN y = 0 THEN toInteger(x) * 16807
        WHEN x = 0 THEN toInteger(y) * 48271
        ELSE toInteger(arr[pos - 1]) * toInteger(arr[pos - w])
      END
    ] | arr + [(toInteger(geo) + depth) % 20183]])
  ])])
)

LET risk = reduce(s = 0, pos IN range(0, total - 1) | s + flat_erosion[pos] % 3)
RETURN risk AS part1

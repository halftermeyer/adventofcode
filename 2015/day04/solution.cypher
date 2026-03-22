// AoC 2015 Day 4: The Ideal Stocking Stuffer
// Requires APOC: apoc.util.md5()

CYPHER 25
LET key = $data

LET p1 = reduce(s = {n: 1, found: false}, _ IN range(1, 1000000) |
  CASE WHEN s.found THEN s
  WHEN left(apoc.util.md5([key + toString(s.n)]), 5) = '00000' THEN {n: s.n, found: true}
  ELSE {n: s.n + 1, found: false} END
).n

LET p2 = reduce(s = {n: p1, found: false}, _ IN range(1, 5000000) |
  CASE WHEN s.found THEN s
  WHEN left(apoc.util.md5([key + toString(s.n)]), 6) = '000000' THEN {n: s.n, found: true}
  ELSE {n: s.n + 1, found: false} END
).n

RETURN p1 AS part1, p2 AS part2

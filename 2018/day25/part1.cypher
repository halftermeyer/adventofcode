// AoC 2018 Day 25 — Four-Dimensional Adventure
// Count constellations: groups of 4D points within Manhattan distance 3

CYPHER 25
LET points = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([c IN [split(line, ',')] |
    {a: toInteger(c[0]), b: toInteger(c[1]), c: toInteger(c[2]), d: toInteger(c[3])}
  ])
]
LET n = size(points)

LET result = reduce(
  comp = [i IN range(0, n-1) | i],
  i IN range(0, n-2) |
  reduce(comp2 = comp, j IN range(i+1, n-1) |
    CASE WHEN abs(points[i].a - points[j].a) + abs(points[i].b - points[j].b) + abs(points[i].c - points[j].c) + abs(points[i].d - points[j].d) <= 3
    THEN
      head([ri IN [reduce(r = i, _ IN range(1, n) | comp2[r])] |
        head([rj IN [reduce(r = j, _ IN range(1, n) | comp2[r])] |
          CASE WHEN ri = rj THEN comp2
          ELSE [k IN range(0, n-1) | CASE WHEN comp2[k] = rj THEN ri ELSE comp2[k] END]
          END
        ])
      ])
    ELSE comp2 END
  )
)

LET roots = [i IN range(0, n-1) | reduce(r = i, _ IN range(1, n) | result[r])]
RETURN size(coll.distinct(roots)) AS part1

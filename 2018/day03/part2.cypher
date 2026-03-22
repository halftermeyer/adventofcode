// AoC 2018 Day 3 Part 2 — Find the non-overlapping claim
// Pairwise rectangle overlap test (no grid expansion)

CYPHER 25
LET claims = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([parts IN [split(line, ' ')] |
    head([id IN [toInteger(substring(parts[0], 1))] |
      head([coords IN [split(parts[2], ',')] |
        head([dims IN [split(parts[3], 'x')] |
          {
            id: id,
            l: toInteger(coords[0]),
            t: toInteger(replace(coords[1], ':', '')),
            r: toInteger(coords[0]) + toInteger(dims[0]),
            b: toInteger(replace(coords[1], ':', '')) + toInteger(dims[1])
          }
        ])
      ])
    ])
  ])
]
LET all_ids = [c IN claims | c.id]
RETURN claims, all_ids

NEXT

UNWIND claims AS a
UNWIND claims AS b
WITH all_ids, a, b
WHERE a.id < b.id
  AND a.l < b.r AND b.l < a.r
  AND a.t < b.b AND b.t < a.b
WITH all_ids, collect(DISTINCT a.id) AS left_ids, collect(DISTINCT b.id) AS right_ids
WITH all_ids, coll.distinct(left_ids + right_ids) AS bad_ids
RETURN [id IN all_ids WHERE NOT id IN bad_ids][0] AS part2

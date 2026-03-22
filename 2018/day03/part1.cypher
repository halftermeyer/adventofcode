// AoC 2018 Day 3 Part 1 — Overlapping Fabric Claims
// Expand each claim into individual squares, count those with 2+ claims

CYPHER 25
LET claims = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([parts IN [split(line, ' ')] |
    head([id IN [toInteger(substring(parts[0], 1))] |
      head([coords IN [split(parts[2], ',')] |
        head([dims IN [split(parts[3], 'x')] |
          {
            id: id,
            left: toInteger(coords[0]),
            top: toInteger(replace(coords[1], ':', '')),
            width: toInteger(dims[0]),
            height: toInteger(dims[1])
          }
        ])
      ])
    ])
  ])
]

UNWIND claims AS claim
UNWIND range(claim.left, claim.left + claim.width - 1) AS x
UNWIND range(claim.top, claim.top + claim.height - 1) AS y
WITH x, y, count(*) AS num_claims
WHERE num_claims >= 2
RETURN count(*) AS part1

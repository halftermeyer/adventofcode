// AoC 2015 Day 3: Perfectly Spherical Houses in a Vacuum

CYPHER 25
LET moves = split($data, '')

LET p1 = size(reduce(
  s = {x: 0, y: 0, houses: ['0,0']},
  m IN moves |
  head([nx IN [s.x + CASE m WHEN '>' THEN 1 WHEN '<' THEN -1 ELSE 0 END] |
    head([ny IN [s.y + CASE m WHEN 'v' THEN 1 WHEN '^' THEN -1 ELSE 0 END] |
      head([key IN [toString(nx) + ',' + toString(ny)] |
        {x: nx, y: ny, houses: CASE WHEN key IN s.houses THEN s.houses ELSE s.houses + [key] END}
      ])
    ])
  ])
).houses)

LET p2 = size(reduce(
  s = {sx: 0, sy: 0, rx: 0, ry: 0, turn: 0, houses: ['0,0']},
  m IN moves |
  CASE WHEN s.turn % 2 = 0 THEN
    head([nx IN [s.sx + CASE m WHEN '>' THEN 1 WHEN '<' THEN -1 ELSE 0 END] |
      head([ny IN [s.sy + CASE m WHEN 'v' THEN 1 WHEN '^' THEN -1 ELSE 0 END] |
        head([key IN [toString(nx) + ',' + toString(ny)] |
          {sx: nx, sy: ny, rx: s.rx, ry: s.ry, turn: s.turn + 1,
           houses: CASE WHEN key IN s.houses THEN s.houses ELSE s.houses + [key] END}
        ])])])
  ELSE
    head([nx IN [s.rx + CASE m WHEN '>' THEN 1 WHEN '<' THEN -1 ELSE 0 END] |
      head([ny IN [s.ry + CASE m WHEN 'v' THEN 1 WHEN '^' THEN -1 ELSE 0 END] |
        head([key IN [toString(nx) + ',' + toString(ny)] |
          {sx: s.sx, sy: s.sy, rx: nx, ry: ny, turn: s.turn + 1,
           houses: CASE WHEN key IN s.houses THEN s.houses ELSE s.houses + [key] END}
        ])])])
  END
).houses)

RETURN p1 AS part1, p2 AS part2

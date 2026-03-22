// AoC 2018 Day 18 Part 1 — Settlers of The North Pole (10 minutes)

CYPHER 25
LET grid = [row IN split($data, '\n') WHERE size(row) > 0 | split(row, '')]
LET h = size(grid)
LET w = size(grid[0])
LET flat = reduce(acc = [], row IN grid | acc + row)

LET result = reduce(
  state = flat,
  minute IN range(1, 10) |
  [ix IN range(0, h*w - 1) |
    head([c IN [ix % w] |
      head([neighbors IN [[d IN [1, -1, w, -w, w+1, w-1, -w+1, -w-1]
        WHERE ix + d >= 0 AND ix + d < h*w AND abs((ix+d) % w - c) <= 1
        | state[ix + d]]] |
        head([nt IN [size([n IN neighbors WHERE n = '|'])] |
          head([nl IN [size([n IN neighbors WHERE n = '#'])] |
            CASE state[ix]
              WHEN '.' THEN CASE WHEN nt >= 3 THEN '|' ELSE '.' END
              WHEN '|' THEN CASE WHEN nl >= 3 THEN '#' ELSE '|' END
              WHEN '#' THEN CASE WHEN nl >= 1 AND nt >= 1 THEN '#' ELSE '.' END
              ELSE state[ix]
            END
          ])
        ])
      ])
    ])
  ]
)

LET tc = size([c IN result WHERE c = '|'])
LET lc = size([c IN result WHERE c = '#'])
RETURN tc * lc AS part1

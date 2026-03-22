// AoC 2018 Day 11 Part 2 — Best NxN square (any size)
// Uses row prefix sums for efficient computation

CYPHER 25
LET serial = 5235

LET grid = [y IN range(1, 300) |
  [x IN range(1, 300) |
    ((((x + 10) * y + serial) * (x + 10)) / 100) % 10 - 5
  ]
]

LET row_prefix = [y IN range(0, 299) |
  reduce(acc = [0], x IN range(0, 299) | acc + [acc[-1] + grid[y][x]])
]

UNWIND range(1, 30) AS s
WITH grid, row_prefix, s,
  [ty IN range(0, 300-s) |
    [tx IN range(0, 300-s) |
      {x: tx+1, y: ty+1, s: s, power:
        reduce(p = 0, dy IN range(0, s-1) | p + row_prefix[ty+dy][tx+s] - row_prefix[ty+dy][tx])
      }
    ]
  ] AS results_for_size
WITH s, reduce(acc = [], row IN results_for_size | acc + row) AS flat
WITH s, reduce(b = {x:0, y:0, s:0, power:-999}, r IN flat |
  CASE WHEN r.power > b.power THEN r ELSE b END
) AS best
ORDER BY best.power DESC
LIMIT 1
RETURN best.x + ',' + best.y + ',' + best.s AS part2, best.power AS power

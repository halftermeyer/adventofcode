// AoC 2018 Day 11 Part 1 — Best 3x3 square

CYPHER 25
LET serial = 5235

LET grid = [y IN range(1, 300) |
  [x IN range(1, 300) |
    ((((x + 10) * y + serial) * (x + 10)) / 100) % 10 - 5
  ]
]

LET results = [ty IN range(0, 297) |
  [tx IN range(0, 297) |
    {x: tx+1, y: ty+1, power:
      grid[ty][tx] + grid[ty][tx+1] + grid[ty][tx+2] +
      grid[ty+1][tx] + grid[ty+1][tx+1] + grid[ty+1][tx+2] +
      grid[ty+2][tx] + grid[ty+2][tx+1] + grid[ty+2][tx+2]
    }
  ]
]

LET flat = reduce(acc = [], row IN results | acc + row)
LET best = reduce(b = {x:0, y:0, power:-999}, r IN flat |
  CASE WHEN r.power > b.power THEN r ELSE b END
)
RETURN best.x + ',' + best.y AS part1, best.power AS power

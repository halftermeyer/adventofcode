// AoC 2015 Day 2: I Was Told There Would Be No Math

CYPHER 25
LET boxes = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([dims IN [[d IN split(line, 'x') | toInteger(d)]] |
    {l: dims[0], w: dims[1], h: dims[2]}
  ])
]

LET part1 = reduce(s = 0, b IN boxes |
  s + 2*b.l*b.w + 2*b.w*b.h + 2*b.h*b.l +
  reduce(m = b.l*b.w, side IN [b.w*b.h, b.h*b.l] | CASE WHEN side < m THEN side ELSE m END)
)

LET part2 = reduce(s = 0, b IN boxes |
  head([sorted IN [coll.sort([b.l, b.w, b.h])] |
    s + 2*sorted[0] + 2*sorted[1] + b.l*b.w*b.h
  ])
)

RETURN part1, part2

// AoC 2015 Day 1: Not Quite Lisp
// CS: fold/accumulate | Graph: none

CYPHER 25
LET chars = split($data, '')

LET p1 = reduce(floor = 0, ch IN chars | floor + CASE ch WHEN '(' THEN 1 ELSE -1 END)

LET p2 = reduce(
  s = {floor: 0, pos: 0, found: false},
  ch IN chars |
  CASE WHEN s.found THEN s ELSE
    head([nf IN [s.floor + CASE ch WHEN '(' THEN 1 ELSE -1 END] |
      CASE WHEN nf = -1 THEN {floor: nf, pos: s.pos + 1, found: true}
      ELSE {floor: nf, pos: s.pos + 1, found: false} END
    ])
  END
).pos

RETURN p1 AS part1, p2 AS part2

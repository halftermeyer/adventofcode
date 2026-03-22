// AoC 2015 Day 10: Elves Look, Elves Say
// 50 iterations of look-and-say producing ~3.6M char string

CYPHER 25
LET input = $data

LET result = reduce(seq = input, iter IN range(1, 50) |
  head([chars IN [split(seq, '')] |
    head([encoded IN [reduce(
      s = {result: '', current: '', count: 0},
      ch IN chars |
      CASE WHEN ch = s.current
        THEN {result: s.result, current: s.current, count: s.count + 1}
        ELSE CASE WHEN s.count > 0
          THEN {result: s.result + toString(s.count) + s.current, current: ch, count: 1}
          ELSE {result: '', current: ch, count: 1} END
      END
    )] | encoded.result + toString(encoded.count) + encoded.current])
  ])
)

RETURN size(result) AS part2
// For part1: change range(1, 50) to range(1, 40)

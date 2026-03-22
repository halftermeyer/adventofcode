// AoC 2017 Day 13: Packet Scanners
// CS: Modular arithmetic | Graph: none

CYPHER 25
LET scanners = [l IN split($data, '\n') WHERE size(l) > 0 |
  head([parts IN [split(l, ': ')] |
    {depth: toInteger(trim(parts[0])), range: toInteger(trim(parts[1]))}])]

LET part1 = reduce(s=0, sc IN scanners |
  s + CASE WHEN sc.depth % (2*(sc.range-1)) = 0 THEN sc.depth * sc.range ELSE 0 END)

LET part2 = reduce(s={delay:0, found:false}, try IN range(0, 10000000) |
  CASE WHEN s.found THEN s ELSE
    CASE WHEN size([sc IN scanners WHERE (try+sc.depth) % (2*(sc.range-1)) = 0]) = 0
      THEN {delay:try, found:true}
      ELSE s END
  END
).delay

RETURN part1, part2

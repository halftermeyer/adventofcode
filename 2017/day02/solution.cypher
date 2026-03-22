// AoC 2017 Day 2: Corruption Checksum
// CS: Nested iteration / divisibility | Graph: none

CYPHER 25
LET rows = [l IN split($data, '\n') WHERE size(l) > 0 |
  [n IN split(l, '\t') WHERE size(n) > 0 | toInteger(n)]]

LET part1 = reduce(s=0, row IN rows |
  s + reduce(mx=0, v IN row | CASE WHEN v>mx THEN v ELSE mx END)
    - reduce(mn=99999, v IN row | CASE WHEN v<mn THEN v ELSE mn END))

LET part2 = reduce(s=0, row IN rows |
  s + head([pair IN [r IN range(0,size(row)-1), c IN range(0,size(row)-1)
    WHERE r<>c AND row[r] % row[c] = 0 | row[r]/row[c]] | pair]))

RETURN part1, part2

// AoC 2017 Day 4: High-Entropy Passphrases
// CS: Set operations / anagram detection | Graph: none

CYPHER 25
LET lines = [l IN split($data, '\n') WHERE size(l) > 0]

LET part1 = size([l IN lines WHERE
  head([words IN [split(l, ' ')] |
    size(words) = size(coll.distinct(words))])])

LET part2 = size([l IN lines WHERE
  head([words IN [split(l, ' ')] |
    head([sorted IN [[w IN words | reduce(s='', ch IN coll.sort(split(w,'')) | s+ch)]] |
      size(sorted) = size(coll.distinct(sorted))])])])

RETURN part1, part2

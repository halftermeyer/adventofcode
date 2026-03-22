// AoC 2018 Day 5 Part 2 — Best single-letter removal
// For each letter a-z, filter it out, reduce, find shortest

CYPHER 25
LET chars = split($data, '')
LET alphabet = split('abcdefghijklmnopqrstuvwxyz', '')

LET results = [letter IN alphabet |
  size(reduce(
    s = [],
    ch IN [c IN chars WHERE toLower(c) <> letter] |
    CASE
      WHEN size(s) > 0
        AND s[-1] <> ch
        AND toLower(s[-1]) = toLower(ch)
      THEN s[0..-1]
      ELSE s + [ch]
    END
  ))
]

RETURN reduce(best = results[0], r IN results | CASE WHEN r < best THEN r ELSE best END) AS part2

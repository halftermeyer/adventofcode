// AoC 2018 Day 5 Part 1 — Polymer Reduction
// Stack machine: push char, pop if top reacts (same letter, different case)

CYPHER 25
LET chars = split($data, '')

LET stack = reduce(
  s = [],
  ch IN chars |
  CASE
    WHEN size(s) > 0
      AND s[-1] <> ch
      AND toLower(s[-1]) = toLower(ch)
    THEN s[0..-1]
    ELSE s + [ch]
  END
)
RETURN size(stack) AS part1

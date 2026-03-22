// AoC 2018 Day 2 Part 2 — Common letters between IDs differing by exactly 1 char

CYPHER 25
LET ids = [line IN split($data, '\n') WHERE size(line) > 0]

UNWIND range(0, size(ids)-2) AS i
UNWIND range(i+1, size(ids)-1) AS j
WITH ids[i] AS a, ids[j] AS b
WHERE size([ix IN range(0, size(split(a,''))-1) WHERE split(a,'')[ix] <> split(b,'')[ix]]) = 1
WITH a, b
LIMIT 1
RETURN reduce(s = '', ix IN range(0, size(split(a,''))-1) |
  s + CASE WHEN split(a,'')[ix] = split(b,'')[ix] THEN split(a,'')[ix] ELSE '' END
) AS part2

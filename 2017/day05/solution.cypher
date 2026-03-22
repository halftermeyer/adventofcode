// AoC 2017 Day 5: Twisty Trampolines
// CS: Jump list VM | Graph: none
// Part 2 omitted (too many iterations for pure Cypher)

CYPHER 25
LET offsets = [l IN split($data, '\n') WHERE size(l) > 0 | toInteger(l)]
LET n = size(offsets)

LET result = reduce(s={pos:0, steps:0, jumps:offsets}, _ IN range(1, 500000) |
  CASE WHEN s.pos < 0 OR s.pos >= n THEN s ELSE
    head([cur IN [s.jumps[s.pos]] |
      {pos: s.pos + cur, steps: s.steps + 1,
       jumps: s.jumps[0..s.pos] + [cur + 1] + s.jumps[s.pos+1..]}
    ]) END
)

RETURN result.steps AS part1

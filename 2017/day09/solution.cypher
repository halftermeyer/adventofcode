// AoC 2017 Day 9: Stream Processing
// CS: Nested parser (garbage, groups) | Graph: none

CYPHER 25
LET chars = split($data, '')

LET result = reduce(s={score:0, depth:0, garbage:false, skip:false, garbageCount:0}, ch IN chars |
  CASE
    WHEN s.skip THEN {score:s.score, depth:s.depth, garbage:s.garbage, skip:false, garbageCount:s.garbageCount}
    WHEN ch = '!' THEN {score:s.score, depth:s.depth, garbage:s.garbage, skip:true, garbageCount:s.garbageCount}
    WHEN s.garbage AND ch = '>' THEN {score:s.score, depth:s.depth, garbage:false, skip:false, garbageCount:s.garbageCount}
    WHEN s.garbage THEN {score:s.score, depth:s.depth, garbage:true, skip:false, garbageCount:s.garbageCount+1}
    WHEN ch = '<' THEN {score:s.score, depth:s.depth, garbage:true, skip:false, garbageCount:s.garbageCount}
    WHEN ch = '{' THEN {score:s.score, depth:s.depth+1, garbage:false, skip:false, garbageCount:s.garbageCount}
    WHEN ch = '}' THEN {score:s.score+s.depth, depth:s.depth-1, garbage:false, skip:false, garbageCount:s.garbageCount}
    ELSE s
  END
)

RETURN result.score AS part1, result.garbageCount AS part2

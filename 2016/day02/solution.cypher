// AoC 2016 Day 2: Bathroom Security
// CS: State machine (keypad navigation) | Graph: none

CYPHER 25
LET lines = [l IN split($data, '\n') WHERE size(l) > 0]

LET p1 = reduce(s = {code: '', pos: 4}, line IN lines |
  head([fp IN [reduce(p = s.pos, ch IN split(line, '') |
    CASE ch WHEN 'U' THEN CASE WHEN p>=3 THEN p-3 ELSE p END
    WHEN 'D' THEN CASE WHEN p<=5 THEN p+3 ELSE p END
    WHEN 'L' THEN CASE WHEN p%3>0 THEN p-1 ELSE p END
    WHEN 'R' THEN CASE WHEN p%3<2 THEN p+1 ELSE p END ELSE p END
  )] | {code: s.code+toString(fp+1), pos: fp}])
)

LET keys = ['_','_','1','_','_','_','2','3','4','_','5','6','7','8','9','_','A','B','C','_','_','_','D','_','_']
LET valid = [2,6,7,8,10,11,12,13,14,16,17,18,22]

LET p2 = reduce(s = {code: '', pos: 10}, line IN lines |
  head([fp IN [reduce(p = s.pos, ch IN split(line, '') |
    head([np IN [CASE ch WHEN 'U' THEN p-5 WHEN 'D' THEN p+5 WHEN 'L' THEN p-1 WHEN 'R' THEN p+1 ELSE p END] |
      CASE WHEN np IN valid THEN np ELSE p END])
  )] | {code: s.code+keys[fp], pos: fp}])
)

RETURN p1.code AS part1, p2.code AS part2

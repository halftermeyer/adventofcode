// AoC 2016 Day 6: Signals and Noise
// CS: Column frequency analysis | Graph: none

CYPHER 25
LET lines = [l IN split($data, '\n') WHERE size(l) > 0]
LET width = size(lines[0])
LET alpha = split('abcdefghijklmnopqrstuvwxyz', '')

LET part1 = reduce(msg='', col IN range(0, width-1) | msg+reduce(best={ch:'',cnt:0}, ch IN alpha |
  head([cnt IN [size([l IN lines WHERE split(l,'')[col]=ch])] |
    CASE WHEN cnt>best.cnt THEN {ch:ch,cnt:cnt} ELSE best END])).ch)

LET part2 = reduce(msg='', col IN range(0, width-1) | msg+reduce(best={ch:'',cnt:9999}, ch IN alpha |
  head([cnt IN [size([l IN lines WHERE split(l,'')[col]=ch])] |
    CASE WHEN cnt>0 AND cnt<best.cnt THEN {ch:ch,cnt:cnt} ELSE best END])).ch)

RETURN part1, part2

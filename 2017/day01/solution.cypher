// AoC 2017 Day 1: Inverse Captcha
// CS: Circular array matching | Graph: none

CYPHER 25
LET digits = [ch IN split($data, '') WHERE ch >= '0' AND ch <= '9' | toInteger(ch)]
LET n = size(digits)

LET part1 = reduce(s=0, i IN range(0, n-1) |
  s + CASE WHEN digits[i] = digits[(i+1) % n] THEN digits[i] ELSE 0 END)

LET part2 = reduce(s=0, i IN range(0, n-1) |
  s + CASE WHEN digits[i] = digits[(i + n/2) % n] THEN digits[i] ELSE 0 END)

RETURN part1, part2

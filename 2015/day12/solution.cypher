// AoC 2015 Day 12: JSAbacusio.com
// CS: parsing | Graph: none
// reduce() char-by-char number extractor

CYPHER 25
LET chars = split($data, '')
LET digits = split('0123456789', '')

LET result = reduce(
  s = {sum: 0, current: '', inNumber: false},
  ch IN chars |
  CASE
    WHEN ch IN digits OR (ch = '-' AND NOT s.inNumber)
      THEN {sum: s.sum, current: s.current + ch, inNumber: true}
    WHEN s.inNumber
      THEN {sum: s.sum + toInteger(s.current), current: '', inNumber: false}
    ELSE s
  END
)

LET part1 = CASE WHEN result.inNumber
  THEN result.sum + toInteger(result.current)
  ELSE result.sum
END

RETURN part1

// AoC 2015 Day 25: Let It Snow
// CS: modular exponentiation | Graph: none
// reduce() square-and-multiply

CYPHER 25
// Parse row and column from input like "row 2981, column 3075"
LET words = split($data, ' ')
LET row = toInteger(replace([w IN words WHERE size(w) > 0][15], ',', ''))
LET col = toInteger(replace([w IN words WHERE size(w) > 0][17], '.', ''))

// Compute linear index from diagonal grid position
LET diag = row + col - 1
LET idx = (diag * (diag - 1)) / 2 + col

// Constants
LET base = 252533
LET modulus = 33554393
LET seed = 20151125
LET exp = idx - 1

// Modular exponentiation: base^exp mod modulus via square-and-multiply
// Decompose exponent into bits, then reduce
LET bits = [i IN range(0, 30) WHERE (exp / toInteger(2^i)) % 2 = 1 | i]

LET power = reduce(s = {result: 1, basePow: base}, i IN range(0, 30) |
  {result: CASE WHEN i IN bits THEN (s.result * s.basePow) % modulus ELSE s.result END,
   basePow: (s.basePow * s.basePow) % modulus}
).result

LET part1 = (seed * power) % modulus

RETURN part1

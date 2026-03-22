// AoC 2015 Day 15: Science for Hungry People
// CS: constraint optimization | Graph: none
// UNWIND 4-ingredient combos (101^3 ~ 1M combinations)

CYPHER 25
LET ingredients = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([parts IN [split(line, ' ')] |
    {capacity: toInteger(replace(parts[2], ',', '')),
     durability: toInteger(replace(parts[4], ',', '')),
     flavor: toInteger(replace(parts[6], ',', '')),
     texture: toInteger(replace(parts[8], ',', '')),
     calories: toInteger(parts[10])}
  ])
]

UNWIND range(0, 100) AS a
UNWIND range(0, 100 - a) AS b
UNWIND range(0, 100 - a - b) AS c
WITH a, b, c, 100 - a - b - c AS d, ingredients
WITH [a, b, c, d] AS amounts, ingredients
WITH
  reduce(s = 0, i IN range(0, 3) | s + amounts[i] * ingredients[i].capacity) AS cap,
  reduce(s = 0, i IN range(0, 3) | s + amounts[i] * ingredients[i].durability) AS dur,
  reduce(s = 0, i IN range(0, 3) | s + amounts[i] * ingredients[i].flavor) AS flav,
  reduce(s = 0, i IN range(0, 3) | s + amounts[i] * ingredients[i].texture) AS tex,
  reduce(s = 0, i IN range(0, 3) | s + amounts[i] * ingredients[i].calories) AS cal
WHERE cap > 0 AND dur > 0 AND flav > 0 AND tex > 0
WITH cap * dur * flav * tex AS score, cal
RETURN max(score) AS part1,
       max(CASE WHEN cal = 500 THEN score END) AS part2

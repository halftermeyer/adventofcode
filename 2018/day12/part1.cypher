// AoC 2018 Day 12 Part 1 — Cellular automaton, 20 generations

CYPHER 25
LET lines = [line IN split($data, '\n') WHERE size(line) > 0]
LET initial_state = split(split(lines[0], ': ')[1], '')
LET rules = [line IN lines[1..] | {pattern: split(split(line, ' => ')[0], ''), result: split(line, ' => ')[1]}]
LET rule_set = [r IN rules WHERE r.result = '#' | reduce(s = '', ch IN r.pattern | s + ch)]
LET initial_pots = [ix IN range(0, size(initial_state)-1) WHERE initial_state[ix] = '#' | ix]

LET result = reduce(
  pots = initial_pots,
  gen IN range(1, 20) |
  head([min_pot IN [reduce(m = 9999, p IN pots | CASE WHEN p < m THEN p ELSE m END)] |
    head([max_pot IN [reduce(m = -9999, p IN pots | CASE WHEN p > m THEN p ELSE m END)] |
      [p IN range(min_pot - 2, max_pot + 2) WHERE
        reduce(s = '', dx IN range(-2, 2) | s + CASE WHEN (p + dx) IN pots THEN '#' ELSE '.' END) IN rule_set
      ]
    ])
  ])
)

RETURN reduce(s = 0, p IN result | s + p) AS part1

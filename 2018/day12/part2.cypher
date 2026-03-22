// AoC 2018 Day 12 Part 2 — 50 billion generations via cycle detection

CYPHER 25
LET lines = [line IN split($data, '\n') WHERE size(line) > 0]
LET initial_state = split(split(lines[0], ': ')[1], '')
LET rules = [line IN lines[1..] | {pattern: split(split(line, ' => ')[0], ''), result: split(line, ' => ')[1]}]
LET rule_set = [r IN rules WHERE r.result = '#' | reduce(s = '', ch IN r.pattern | s + ch)]
LET initial_pots = [ix IN range(0, size(initial_state)-1) WHERE initial_state[ix] = '#' | ix]

LET result = reduce(
  s = {pots: initial_pots, prev_sum: 0, prev_delta: 0, streak: 0, stable_gen: -1, stable_sum: 0, stable_delta: 0},
  gen IN range(1, 200) |
  CASE WHEN s.stable_gen > 0 THEN s ELSE
    head([min_pot IN [reduce(m = 9999, p IN s.pots | CASE WHEN p < m THEN p ELSE m END)] |
      head([max_pot IN [reduce(m = -9999, p IN s.pots | CASE WHEN p > m THEN p ELSE m END)] |
        head([new_pots IN [[p IN range(min_pot - 2, max_pot + 2) WHERE
          reduce(str = '', dx IN range(-2, 2) | str + CASE WHEN (p + dx) IN s.pots THEN '#' ELSE '.' END) IN rule_set
        ]] |
          head([new_sum IN [reduce(tot = 0, p IN new_pots | tot + p)] |
            head([delta IN [new_sum - s.prev_sum] |
              head([new_streak IN [CASE WHEN delta = s.prev_delta THEN s.streak + 1 ELSE 1 END] |
                CASE WHEN new_streak >= 5
                  THEN {pots: new_pots, prev_sum: new_sum, prev_delta: delta, streak: new_streak,
                        stable_gen: gen, stable_sum: new_sum, stable_delta: delta}
                  ELSE {pots: new_pots, prev_sum: new_sum, prev_delta: delta, streak: new_streak,
                        stable_gen: -1, stable_sum: 0, stable_delta: 0}
                END
              ])
            ])
          ])
        ])
      ])
    ])
  END
)

RETURN result.stable_sum + (50000000000 - result.stable_gen) * result.stable_delta AS part2

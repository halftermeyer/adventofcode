// AoC 2018 Day 18 Part 2 — 1 billion minutes via cycle detection

CYPHER 25
LET grid = [row IN split($data, '\n') WHERE size(row) > 0 | split(row, '')]
LET h = size(grid)
LET w = size(grid[0])
LET flat = reduce(acc = [], row IN grid | acc + row)

LET trace = reduce(
  s = {state: flat, history: [], found_cycle: false, cycle_start: -1, cycle_len: -1},
  minute IN range(1, 1000) |
  CASE WHEN s.found_cycle THEN s ELSE
    head([new_state IN [[ix IN range(0, h*w - 1) |
      head([c IN [ix % w] |
        head([neighbors IN [[d IN [1, -1, w, -w, w+1, w-1, -w+1, -w-1]
          WHERE ix + d >= 0 AND ix + d < h*w AND abs((ix+d) % w - c) <= 1
          | s.state[ix + d]]] |
          head([nt IN [size([n IN neighbors WHERE n = '|'])] |
            head([nl IN [size([n IN neighbors WHERE n = '#'])] |
              CASE s.state[ix]
                WHEN '.' THEN CASE WHEN nt >= 3 THEN '|' ELSE '.' END
                WHEN '|' THEN CASE WHEN nl >= 3 THEN '#' ELSE '|' END
                WHEN '#' THEN CASE WHEN nl >= 1 AND nt >= 1 THEN '#' ELSE '.' END
                ELSE s.state[ix]
              END
            ])
          ])
        ])
      ])
    ]] |
      head([rv IN [size([c IN new_state WHERE c = '|']) * size([c IN new_state WHERE c = '#'])] |
        head([match_idx IN [coll.indexOf([h IN s.history | h.rv], rv)] |
          CASE WHEN match_idx >= 0 AND minute > 50
            THEN {state: new_state, history: s.history + [{minute: minute, rv: rv}],
                  found_cycle: true, cycle_start: match_idx, cycle_len: minute - s.history[match_idx].minute}
            ELSE {state: new_state, history: s.history + [{minute: minute, rv: rv}],
                  found_cycle: false, cycle_start: -1, cycle_len: -1}
          END
        ])
      ])
    ])
  END
)

LET cs = trace.cycle_start
LET cl = trace.cycle_len
LET target_idx = cs + ((1000000000 - 1 - cs) % cl)
RETURN trace.history[target_idx].rv AS part2

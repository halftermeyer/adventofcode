// AoC 2015 Day 7: Some Assembly Required
// 339-wire circuit with bitwise AND/OR via bit decomposition

CYPHER 25
LET lines = [l IN split($data, '\n') WHERE size(l) > 0 | split(l, ' -> ')]
LET instructions = [l IN lines | {target: l[1], expr: split(l[0], ' ')}]

LET result = reduce(
  s = {resolved: [], remaining: instructions},
  _ IN range(1, 500) |
  CASE WHEN size(s.remaining) = 0 THEN s ELSE
    head([newly IN [[i IN s.remaining |
      head([e IN [i.expr] | head([t IN [i.target] |
        head([val IN [
          CASE size(e)
            WHEN 1 THEN CASE WHEN e[0] =~ '[0-9]+' THEN toInteger(e[0]) ELSE head([r IN s.resolved WHERE r.name = e[0] | r.value]) END
            WHEN 2 THEN head([v IN [head([r IN s.resolved WHERE r.name = e[1] | r.value])] | CASE WHEN v IS NOT NULL THEN 65535 - v ELSE null END])
            WHEN 3 THEN
              head([a IN [CASE WHEN e[0] =~ '[0-9]+' THEN toInteger(e[0]) ELSE head([r IN s.resolved WHERE r.name = e[0] | r.value]) END] |
                head([b IN [CASE WHEN e[2] =~ '[0-9]+' THEN toInteger(e[2]) ELSE head([r IN s.resolved WHERE r.name = e[2] | r.value]) END] |
                  CASE WHEN a IS NOT NULL AND b IS NOT NULL THEN
                    CASE e[1]
                      WHEN 'AND' THEN reduce(s2=0, bit IN range(0,15) | s2 + CASE WHEN (a/toInteger(2^bit))%2=1 AND (b/toInteger(2^bit))%2=1 THEN toInteger(2^bit) ELSE 0 END)
                      WHEN 'OR' THEN reduce(s2=0, bit IN range(0,15) | s2 + CASE WHEN (a/toInteger(2^bit))%2=1 OR (b/toInteger(2^bit))%2=1 THEN toInteger(2^bit) ELSE 0 END)
                      WHEN 'LSHIFT' THEN (a * toInteger(2^b)) % 65536
                      WHEN 'RSHIFT' THEN a / toInteger(2^b)
                    END
                  ELSE null END])
              ])
            ELSE null END
        ] | CASE WHEN val IS NOT NULL THEN {name: t, value: val} ELSE null END])
      ])])
    ]] |
      head([new_r IN [[n IN newly WHERE n IS NOT NULL]] |
        {resolved: s.resolved + new_r, remaining: [i IN s.remaining WHERE NOT i.target IN [n IN new_r | n.name]]}
      ])
    ])
  END
)

RETURN head([r IN result.resolved WHERE r.name = 'a' | r.value]) AS part1
// Part 2: override wire b with part1 answer, re-run (modify input)

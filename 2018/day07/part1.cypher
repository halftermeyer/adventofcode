// AoC 2018 Day 7 Part 1 — Topological Sort with alphabetical priority

CYPHER 25
LET edges = [line IN split($data, '\n') WHERE size(line) > 0 |
  {from: substring(line, 5, 1), to: substring(line, 36, 1)}
]
LET all_steps = coll.distinct([e IN edges | e.from] + [e IN edges | e.to])

LET result = reduce(
  s = {done: [], remaining: all_steps},
  _ IN range(1, size(all_steps)) |
  head([ready IN [coll.sort([step IN s.remaining
    WHERE none(e IN edges WHERE e.to = step AND NOT e.from IN s.done)])] |
    {done: s.done + [ready[0]], remaining: [r IN s.remaining WHERE r <> ready[0]]}
  ])
)

RETURN reduce(s = '', ch IN result.done | s + ch) AS part1

// AoC 2018 Day 4 Part 1 — Guard with most total sleep * their most-slept minute

CYPHER 25
LET lines = [line IN split($data, '\n') WHERE size(line) > 0]
UNWIND lines AS line
WITH line ORDER BY line
WITH collect(line) AS sorted_lines

LET events = reduce(
  s = {guard: 0, result: []},
  line IN sorted_lines |
  CASE
    WHEN line CONTAINS 'Guard' THEN
      head([gid IN [toInteger(split(split(line, '#')[1], ' ')[0])] |
        {guard: gid, result: s.result}
      ])
    WHEN line CONTAINS 'falls asleep' THEN
      head([minute IN [toInteger(split(split(line, ':')[1], ']')[0])] |
        {guard: s.guard, result: s.result + [{guard: s.guard, type: 'sleep', minute: minute}]}
      ])
    WHEN line CONTAINS 'wakes up' THEN
      head([minute IN [toInteger(split(split(line, ':')[1], ']')[0])] |
        {guard: s.guard, result: s.result + [{guard: s.guard, type: 'wake', minute: minute}]}
      ])
    ELSE s
  END
).result
RETURN events

NEXT

LET intervals = [ix IN range(0, size(events)-1) WHERE events[ix].type = 'sleep' |
  {guard: events[ix].guard, from: events[ix].minute, to: events[ix+1].minute}
]
RETURN intervals

NEXT

UNWIND intervals AS iv
UNWIND range(iv.from, iv.to - 1) AS minute
WITH iv.guard AS guard, minute
WITH guard, minute, count(*) AS cnt
ORDER BY cnt DESC
WITH guard, sum(cnt) AS total_sleep, collect({minute: minute, cnt: cnt}) AS minutes
ORDER BY total_sleep DESC
LIMIT 1
RETURN guard * minutes[0].minute AS part1

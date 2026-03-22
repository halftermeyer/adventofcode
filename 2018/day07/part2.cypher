// AoC 2018 Day 7 Part 2 — 5 workers, step time = 60 + letter position

CYPHER 25
LET edges = [line IN split($data, '\n') WHERE size(line) > 0 |
  {from: substring(line, 5, 1), to: substring(line, 36, 1)}
]
LET all_steps = coll.sort(coll.distinct([e IN edges | e.from] + [e IN edges | e.to]))
LET alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

LET result = reduce(
  s = {time: 0, done: [], wip: [], remaining: all_steps},
  _ IN range(1, 2000) |
  CASE WHEN size(s.remaining) = 0 AND size(s.wip) = 0 THEN s ELSE
    head([t IN [CASE WHEN size(s.wip) > 0
      THEN reduce(m = 9999, w IN s.wip | CASE WHEN w.finish < m THEN w.finish ELSE m END)
      ELSE s.time END] |
      head([newly_done IN [[w IN s.wip WHERE w.finish = t | w.step]] |
        head([done2 IN [s.done + newly_done] |
          head([wip2 IN [[w IN s.wip WHERE w.finish > t]] |
            head([ready IN [coll.sort([step IN s.remaining
              WHERE none(e IN edges WHERE e.to = step AND NOT e.from IN done2)])] |
              head([num_assign IN [CASE WHEN 5 - size(wip2) < size(ready) THEN 5 - size(wip2) ELSE size(ready) END] |
                head([assigned IN [ready[0..num_assign]] |
                  {
                    time: t,
                    done: done2,
                    wip: wip2 + [a IN assigned | {step: a, finish: t + 61 + coll.indexOf(split(alpha,''), a)}],
                    remaining: [r IN s.remaining WHERE NOT r IN assigned]
                  }
                ])
              ])
            ])
          ])
        ])
      ])
    ])
  END
)

RETURN result.time AS part2

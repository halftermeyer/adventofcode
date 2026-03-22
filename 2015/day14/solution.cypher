// AoC 2015 Day 14: Reindeer Olympics
// CS: simulation | Graph: none
// Modular arithmetic + per-second scoring via reduce()

CYPHER 25
LET reindeer = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([w IN [split(line, ' ')] |
    {name: w[0], speed: toInteger(w[3]), flyTime: toInteger(w[6]), restTime: toInteger(w[13])}
  ])
]

LET totalTime = 2503

// Part 1: distance at t=2503 via modular arithmetic
LET part1 = reduce(best = 0, r IN reindeer |
  head([cycle IN [r.flyTime + r.restTime] |
    head([fullCycles IN [totalTime / cycle] |
      head([remaining IN [totalTime % cycle] |
        head([flyRemaining IN [CASE WHEN remaining > r.flyTime THEN r.flyTime ELSE remaining END] |
          head([dist IN [(fullCycles * r.flyTime + flyRemaining) * r.speed] |
            CASE WHEN dist > best THEN dist ELSE best END
          ])
        ])
      ])
    ])
  ])
)

// Part 2: per-second scoring
LET part2 = head([scores IN [reduce(
  s = [r IN reindeer | {name: r.name, speed: r.speed, flyTime: r.flyTime, restTime: r.restTime, dist: 0, points: 0}],
  t IN range(1, totalTime) |
  head([updated IN [[r IN s |
    head([cycle IN [r.flyTime + r.restTime] |
      head([phase IN [t % cycle] |
        head([flying IN [phase > 0 AND phase <= r.flyTime] |
          {name: r.name, speed: r.speed, flyTime: r.flyTime, restTime: r.restTime,
           dist: r.dist + CASE WHEN flying THEN r.speed ELSE 0 END, points: r.points}
        ])
      ])
    ])
  ]] |
    head([maxDist IN [reduce(m = 0, r IN updated | CASE WHEN r.dist > m THEN r.dist ELSE m END)] |
      [r IN updated | {name: r.name, speed: r.speed, flyTime: r.flyTime, restTime: r.restTime,
                        dist: r.dist, points: r.points + CASE WHEN r.dist = maxDist THEN 1 ELSE 0 END}]
    ])
  ])
)] | reduce(best = 0, r IN scores | CASE WHEN r.points > best THEN r.points ELSE best END)])

RETURN part1, part2

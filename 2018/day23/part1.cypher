// AoC 2018 Day 23 Part 1 — Nanobot with largest radius, count bots in range

CYPHER 25
LET bots = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([parts IN [split(replace(replace(line, 'pos=<', ''), '>', ''), ',')] |
    head([r_str IN [split(parts[3], '=')] |
      {x: toInteger(parts[0]), y: toInteger(parts[1]), z: toInteger(parts[2]), r: toInteger(r_str[1])}
    ])
  ])
]

LET strongest = reduce(b = bots[0], bot IN bots | CASE WHEN bot.r > b.r THEN bot ELSE b END)
LET in_range = size([bot IN bots WHERE abs(bot.x - strongest.x) + abs(bot.y - strongest.y) + abs(bot.z - strongest.z) <= strongest.r])

RETURN in_range AS part1

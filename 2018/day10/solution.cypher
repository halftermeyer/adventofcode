// AoC 2018 Day 10 — The Stars Align
// Input must be preprocessed: each line = "px,py,vx,vy"
// Use: :param {data: "<preprocessed input>"}

CYPHER 25
LET points = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([nums IN [[n IN split(line, ',') | toInteger(n)]] |
    {px: nums[0], py: nums[1], vx: nums[2], vy: nums[3]}
  ])
]

LET coarse = [t IN range(0, 20000, 100) |
  head([ys IN [[p IN points | p.py + p.vy * t]] |
    {t: t, h: reduce(mx = -999999, y IN ys | CASE WHEN y > mx THEN y ELSE mx END) -
            reduce(mn = 999999, y IN ys | CASE WHEN y < mn THEN y ELSE mn END)}
  ])
]
LET bc = reduce(b = {t: 0, h: 999999}, h IN coarse | CASE WHEN h.h < b.h THEN h ELSE b END).t
RETURN points, bc

NEXT

LET fine = [t IN range(bc - 100, bc + 100) |
  head([ys IN [[p IN points | p.py + p.vy * t]] |
    {t: t, h: reduce(mx = -999999, y IN ys | CASE WHEN y > mx THEN y ELSE mx END) -
            reduce(mn = 999999, y IN ys | CASE WHEN y < mn THEN y ELSE mn END)}
  ])
]
LET best_t = reduce(b = {t: 0, h: 999999}, h IN fine | CASE WHEN h.h < b.h THEN h ELSE b END).t

LET positions = [p IN points | {x: p.px + p.vx * best_t, y: p.py + p.vy * best_t}]
LET min_x = reduce(m = 999999, p IN positions | CASE WHEN p.x < m THEN p.x ELSE m END)
LET max_x = reduce(m = -999999, p IN positions | CASE WHEN p.x > m THEN p.x ELSE m END)
LET min_y = reduce(m = 999999, p IN positions | CASE WHEN p.y < m THEN p.y ELSE m END)
LET max_y = reduce(m = -999999, p IN positions | CASE WHEN p.y > m THEN p.y ELSE m END)

LET display = [y IN range(min_y, max_y) |
  reduce(row = '', x IN range(min_x, max_x) |
    row + CASE WHEN any(p IN positions WHERE p.x = x AND p.y = y) THEN '#' ELSE '.' END
  )
]
UNWIND display AS row
RETURN row, best_t AS part2

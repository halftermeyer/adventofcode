// AoC 2015 Day 20: Infinite Elves and Infinite Houses
// CS: number theory (divisor sum) | Graph: none
// reduce() with sqrt() divisor sum optimization

CYPHER 25
LET target = toInteger($data)

// Part 1: find lowest house where 10 * sum_of_divisors >= target
LET p1 = reduce(s = {house: 1, found: false}, _ IN range(1, 1000000) |
  CASE WHEN s.found THEN s ELSE
    head([h IN [s.house] |
      head([sqrtH IN [toInteger(sqrt(h))] |
        head([divSum IN [reduce(ds = 0, d IN range(1, sqrtH) |
          CASE WHEN h % d = 0 THEN
            ds + d + CASE WHEN d <> h/d THEN h/d ELSE 0 END
          ELSE ds END
        )] |
          CASE WHEN 10 * divSum >= target
            THEN {house: h, found: true}
            ELSE {house: h + 1, found: false}
          END
        ])
      ])
    ])
  END
).house

// Part 2: each elf visits at most 50 houses, presents = 11 per visit
LET p2 = reduce(s = {house: 1, found: false}, _ IN range(1, 1000000) |
  CASE WHEN s.found THEN s ELSE
    head([h IN [s.house] |
      head([sqrtH IN [toInteger(sqrt(h))] |
        head([divSum IN [reduce(ds = 0, d IN range(1, sqrtH) |
          CASE WHEN h % d = 0 THEN
            ds + CASE WHEN h/d <= 50 THEN d ELSE 0 END
               + CASE WHEN d <> h/d AND d <= 50 THEN h/d ELSE 0 END
          ELSE ds END
        )] |
          CASE WHEN 11 * divSum >= target
            THEN {house: h, found: true}
            ELSE {house: h + 1, found: false}
          END
        ])
      ])
    ])
  END
).house

RETURN p1 AS part1, p2 AS part2

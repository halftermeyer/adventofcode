// AoC 2018 Day 2 Part 1 — Inventory Management System
// Checksum: count(IDs with exactly-2-of-a-letter) * count(IDs with exactly-3-of-a-letter)

CYPHER 25
LET ids = [line IN split($data, '\n') WHERE size(line) > 0]

LET has_two = size([id IN ids WHERE
  any(ch IN split(id, '') WHERE size([c IN split(id, '') WHERE c = ch]) = 2)
])

LET has_three = size([id IN ids WHERE
  any(ch IN split(id, '') WHERE size([c IN split(id, '') WHERE c = ch]) = 3)
])

RETURN has_two * has_three AS part1

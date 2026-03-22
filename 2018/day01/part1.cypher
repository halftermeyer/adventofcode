// AoC 2018 Day 1 Part 1 — Chronal Calibration
// Sum all frequency changes starting from 0.
//
// Setup: :param {data: "<paste input here>"}
// Or run with data embedded (see part1_embedded.cypher)

CYPHER 25
LET changes = [line IN split($data, '\n') WHERE size(line) > 0 | toInteger(line)]
RETURN reduce(freq = 0, c IN changes | freq + c) AS part1

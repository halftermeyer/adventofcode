// AoC 2018 Day 1 Part 2 — First Frequency Reached Twice
// Cycle through changes repeatedly until a frequency is visited a second time.
//
// Technique: Repeat the list 200 times, fold with {freq, found, answer, seen}.
// Short-circuit once found. head() trick for let-binding inside reduce.
//
// Setup: :param {data: "<paste input here>"}

CYPHER 25
LET changes = [line IN split($data, '\n') WHERE size(line) > 0 | toInteger(line)]

LET result = reduce(
  s = {freq: 0, found: false, answer: 0, seen: [0]},
  c IN reduce(acc = [], _ IN range(1, 200) | acc + changes) |
  CASE WHEN s.found THEN s ELSE
    head([new_freq IN [s.freq + c] |
      CASE WHEN new_freq IN s.seen
        THEN {freq: new_freq, found: true, answer: new_freq, seen: s.seen}
        ELSE {freq: new_freq, found: false, answer: 0, seen: s.seen + [new_freq]}
      END
    ])
  END
)

RETURN result.answer AS part2

// AoC 2015 Day 5: Doesn't He Have Intern-Elves For This?

CYPHER 25
LET strings = [s IN split($data, '\n') WHERE size(s) > 0]
LET vowels = split('aeiou', '')

LET part1 = size([s IN strings WHERE
  size([ch IN split(s, '') WHERE ch IN vowels]) >= 3
  AND any(i IN range(0, size(split(s,''))-2) WHERE split(s,'')[i] = split(s,'')[i+1])
  AND NOT (s CONTAINS 'ab' OR s CONTAINS 'cd' OR s CONTAINS 'pq' OR s CONTAINS 'xy')
])

LET part2 = size([s IN strings WHERE
  any(i IN range(0, size(split(s,''))-2) WHERE size(split(s, substring(s, i, 2))) >= 3)
  AND any(i IN range(0, size(split(s,''))-3) WHERE split(s,'')[i] = split(s,'')[i+2])
])

RETURN part1, part2

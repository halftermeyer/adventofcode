// AoC 2015 Day 17: No Such Thing as Too Much
// CS: subset sum | Graph: none
// Bitmask enumeration: 2^20 = 1M subsets

CYPHER 25
LET containers = [line IN split($data, '\n') WHERE size(line) > 0 | toInteger(line)]
LET target = 150
LET n = size(containers)

LET valid = [mask IN range(0, toInteger(2^n) - 1) |
  head([selected IN [[i IN range(0, n-1) WHERE (mask / toInteger(2^i)) % 2 = 1 | containers[i]]] |
    CASE WHEN reduce(s = 0, v IN selected | s + v) = target
      THEN size(selected)
      ELSE null
    END
  ])
]

LET validCounts = [v IN valid WHERE v IS NOT NULL]
LET part1 = size(validCounts)
LET minContainers = reduce(m = size(containers), v IN validCounts | CASE WHEN v < m THEN v ELSE m END)
LET part2 = size([v IN validCounts WHERE v = minContainers])

RETURN part1, part2

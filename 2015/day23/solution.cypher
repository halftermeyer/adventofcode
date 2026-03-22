// AoC 2015 Day 23: Opening the Turing Lock
// CS: VM / interpreter | Graph: none
// reduce() register machine with hlf/tpl/inc/jmp/jie/jio

CYPHER 25
LET program = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([parts IN [split(line, ' ')] |
    {op: parts[0],
     arg1: replace(parts[1], ',', ''),
     arg2: CASE WHEN size(parts) > 2 THEN parts[2] ELSE null END}
  ])
]

LET numInstr = size(program)

// Part 1: a=0, b=0
LET p1 = reduce(s = {a: 0, b: 0, ip: 0}, _ IN range(1, 10000) |
  CASE WHEN s.ip < 0 OR s.ip >= numInstr THEN s ELSE
    head([instr IN [program[s.ip]] |
      CASE instr.op
        WHEN 'hlf' THEN
          CASE instr.arg1 WHEN 'a' THEN {a: s.a / 2, b: s.b, ip: s.ip + 1}
                          ELSE {a: s.a, b: s.b / 2, ip: s.ip + 1} END
        WHEN 'tpl' THEN
          CASE instr.arg1 WHEN 'a' THEN {a: s.a * 3, b: s.b, ip: s.ip + 1}
                          ELSE {a: s.a, b: s.b * 3, ip: s.ip + 1} END
        WHEN 'inc' THEN
          CASE instr.arg1 WHEN 'a' THEN {a: s.a + 1, b: s.b, ip: s.ip + 1}
                          ELSE {a: s.a, b: s.b + 1, ip: s.ip + 1} END
        WHEN 'jmp' THEN {a: s.a, b: s.b, ip: s.ip + toInteger(instr.arg1)}
        WHEN 'jie' THEN
          head([regVal IN [CASE instr.arg1 WHEN 'a' THEN s.a ELSE s.b END] |
            CASE WHEN regVal % 2 = 0 THEN {a: s.a, b: s.b, ip: s.ip + toInteger(instr.arg2)}
            ELSE {a: s.a, b: s.b, ip: s.ip + 1} END
          ])
        WHEN 'jio' THEN
          head([regVal IN [CASE instr.arg1 WHEN 'a' THEN s.a ELSE s.b END] |
            CASE WHEN regVal = 1 THEN {a: s.a, b: s.b, ip: s.ip + toInteger(instr.arg2)}
            ELSE {a: s.a, b: s.b, ip: s.ip + 1} END
          ])
      END
    ])
  END
).b

// Part 2: a=1, b=0
LET p2 = reduce(s = {a: 1, b: 0, ip: 0}, _ IN range(1, 10000) |
  CASE WHEN s.ip < 0 OR s.ip >= numInstr THEN s ELSE
    head([instr IN [program[s.ip]] |
      CASE instr.op
        WHEN 'hlf' THEN
          CASE instr.arg1 WHEN 'a' THEN {a: s.a / 2, b: s.b, ip: s.ip + 1}
                          ELSE {a: s.a, b: s.b / 2, ip: s.ip + 1} END
        WHEN 'tpl' THEN
          CASE instr.arg1 WHEN 'a' THEN {a: s.a * 3, b: s.b, ip: s.ip + 1}
                          ELSE {a: s.a, b: s.b * 3, ip: s.ip + 1} END
        WHEN 'inc' THEN
          CASE instr.arg1 WHEN 'a' THEN {a: s.a + 1, b: s.b, ip: s.ip + 1}
                          ELSE {a: s.a, b: s.b + 1, ip: s.ip + 1} END
        WHEN 'jmp' THEN {a: s.a, b: s.b, ip: s.ip + toInteger(instr.arg1)}
        WHEN 'jie' THEN
          head([regVal IN [CASE instr.arg1 WHEN 'a' THEN s.a ELSE s.b END] |
            CASE WHEN regVal % 2 = 0 THEN {a: s.a, b: s.b, ip: s.ip + toInteger(instr.arg2)}
            ELSE {a: s.a, b: s.b, ip: s.ip + 1} END
          ])
        WHEN 'jio' THEN
          head([regVal IN [CASE instr.arg1 WHEN 'a' THEN s.a ELSE s.b END] |
            CASE WHEN regVal = 1 THEN {a: s.a, b: s.b, ip: s.ip + toInteger(instr.arg2)}
            ELSE {a: s.a, b: s.b, ip: s.ip + 1} END
          ])
      END
    ])
  END
).b

RETURN p1 AS part1, p2 AS part2

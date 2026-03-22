// AoC 2016 Day 12: Leonardo's Monorail — assembunny VM
// CS: Register VM (cpy/inc/dec/jnz) | Graph: none
// Needs 50M iterations for Part 2

CYPHER 25
LET program = [l IN split($data, '\n') WHERE size(l) > 0 | split(l, ' ')]

LET run = [init_c IN [0, 1] |
  reduce(s={a:0,b:0,c:init_c,d:0,ip:0}, _ IN range(1, 50000000) |
    CASE WHEN s.ip<0 OR s.ip>=size(program) THEN s ELSE
      head([i IN [program[s.ip]] | head([gv IN [
        CASE i[1] WHEN 'a' THEN s.a WHEN 'b' THEN s.b WHEN 'c' THEN s.c WHEN 'd' THEN s.d ELSE toInteger(i[1]) END] |
        CASE i[0]
          WHEN 'cpy' THEN head([v IN [gv] | CASE i[2] WHEN 'a' THEN {a:v,b:s.b,c:s.c,d:s.d,ip:s.ip+1} WHEN 'b' THEN {a:s.a,b:v,c:s.c,d:s.d,ip:s.ip+1} WHEN 'c' THEN {a:s.a,b:s.b,c:v,d:s.d,ip:s.ip+1} WHEN 'd' THEN {a:s.a,b:s.b,c:s.c,d:v,ip:s.ip+1} END])
          WHEN 'inc' THEN CASE i[1] WHEN 'a' THEN {a:s.a+1,b:s.b,c:s.c,d:s.d,ip:s.ip+1} WHEN 'b' THEN {a:s.a,b:s.b+1,c:s.c,d:s.d,ip:s.ip+1} WHEN 'c' THEN {a:s.a,b:s.b,c:s.c+1,d:s.d,ip:s.ip+1} WHEN 'd' THEN {a:s.a,b:s.b,c:s.c,d:s.d+1,ip:s.ip+1} END
          WHEN 'dec' THEN CASE i[1] WHEN 'a' THEN {a:s.a-1,b:s.b,c:s.c,d:s.d,ip:s.ip+1} WHEN 'b' THEN {a:s.a,b:s.b-1,c:s.c,d:s.d,ip:s.ip+1} WHEN 'c' THEN {a:s.a,b:s.b,c:s.c-1,d:s.d,ip:s.ip+1} WHEN 'd' THEN {a:s.a,b:s.b,c:s.c,d:s.d-1,ip:s.ip+1} END
          WHEN 'jnz' THEN CASE WHEN gv<>0 THEN {a:s.a,b:s.b,c:s.c,d:s.d,ip:s.ip+CASE i[2] WHEN 'a' THEN s.a WHEN 'b' THEN s.b WHEN 'c' THEN s.c WHEN 'd' THEN s.d ELSE toInteger(i[2]) END} ELSE {a:s.a,b:s.b,c:s.c,d:s.d,ip:s.ip+1} END
          ELSE s END
      ])]) END
  ).a
]

RETURN run[0] AS part1, run[1] AS part2

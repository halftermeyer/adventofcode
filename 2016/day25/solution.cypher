// AoC 2016 Day 25: Clock Signal — find initial a producing 0,1,0,1,...
// CS: VM + output validation | Graph: none

CYPHER 25
LET program = [l IN split($data, '\n') WHERE size(l) > 0 | split(l, ' ')]

LET answer = reduce(s={a_val:0,found:false}, try_a IN range(0,1000) |
  CASE WHEN s.found THEN s ELSE
    head([vm IN [reduce(v={a:try_a,b:0,c:0,d:0,ip:0,output:[],done:false}, _ IN range(1,100000) |
      CASE WHEN v.done OR v.ip<0 OR v.ip>=size(program) OR size(v.output)>=20 THEN
        CASE WHEN size(v.output)>=20 THEN {a:v.a,b:v.b,c:v.c,d:v.d,ip:v.ip,output:v.output,done:true} ELSE v END
      ELSE head([i IN [program[v.ip]] | head([gv IN [CASE i[1] WHEN 'a' THEN v.a WHEN 'b' THEN v.b WHEN 'c' THEN v.c WHEN 'd' THEN v.d ELSE toInteger(i[1]) END] |
        CASE i[0]
          WHEN 'cpy' THEN head([val IN [gv] | CASE i[2] WHEN 'a' THEN {a:val,b:v.b,c:v.c,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'b' THEN {a:v.a,b:val,c:v.c,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'c' THEN {a:v.a,b:v.b,c:val,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'd' THEN {a:v.a,b:v.b,c:v.c,d:val,ip:v.ip+1,output:v.output,done:false} END])
          WHEN 'inc' THEN CASE i[1] WHEN 'a' THEN {a:v.a+1,b:v.b,c:v.c,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'b' THEN {a:v.a,b:v.b+1,c:v.c,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'c' THEN {a:v.a,b:v.b,c:v.c+1,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'd' THEN {a:v.a,b:v.b,c:v.c,d:v.d+1,ip:v.ip+1,output:v.output,done:false} END
          WHEN 'dec' THEN CASE i[1] WHEN 'a' THEN {a:v.a-1,b:v.b,c:v.c,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'b' THEN {a:v.a,b:v.b-1,c:v.c,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'c' THEN {a:v.a,b:v.b,c:v.c-1,d:v.d,ip:v.ip+1,output:v.output,done:false} WHEN 'd' THEN {a:v.a,b:v.b,c:v.c,d:v.d-1,ip:v.ip+1,output:v.output,done:false} END
          WHEN 'jnz' THEN CASE WHEN gv<>0 THEN {a:v.a,b:v.b,c:v.c,d:v.d,ip:v.ip+CASE i[2] WHEN 'a' THEN v.a WHEN 'b' THEN v.b WHEN 'c' THEN v.c WHEN 'd' THEN v.d ELSE toInteger(i[2]) END,output:v.output,done:false} ELSE {a:v.a,b:v.b,c:v.c,d:v.d,ip:v.ip+1,output:v.output,done:false} END
          WHEN 'out' THEN {a:v.a,b:v.b,c:v.c,d:v.d,ip:v.ip+1,output:v.output+[gv],done:false}
          ELSE v END
      ])]) END
    )] | CASE WHEN vm.output=[i IN range(0,size(vm.output)-1)|i%2] THEN {a_val:try_a,found:true} ELSE s END])
  END
).a_val

RETURN answer AS part1

// AoC 2016 Day 9: Explosives in Cyberspace
// CS: Recursive decompression / multiplier stack | Graph: none

CYPHER 25
LET chars = split($data, '')
LET n = size(chars)

LET p1 = reduce(s={i:0,len:0,in_marker:false,marker:''}, _ IN range(1,n+1000) |
  CASE WHEN s.i>=n THEN s
  WHEN chars[s.i]='(' THEN {i:s.i+1,len:s.len,in_marker:true,marker:''}
  WHEN s.in_marker AND chars[s.i]<>')' THEN {i:s.i+1,len:s.len,in_marker:true,marker:s.marker+chars[s.i]}
  WHEN s.in_marker AND chars[s.i]=')' THEN
    head([parts IN [split(s.marker,'x')] |
      head([take IN [toInteger(parts[0])] | head([rep IN [toInteger(parts[1])] |
        {i:s.i+1+take, len:s.len+take*rep, in_marker:false, marker:''}])])])
  ELSE {i:s.i+1,len:s.len+1,in_marker:false,marker:''} END
).len

LET p2 = reduce(s={i:0,total:0,in_marker:false,marker:'',multipliers:[]}, _ IN range(1,n+1000) |
  CASE WHEN s.i>=n THEN s
  WHEN chars[s.i]='(' THEN {i:s.i+1,total:s.total,in_marker:true,marker:'',multipliers:s.multipliers}
  WHEN s.in_marker AND chars[s.i]<>')' THEN {i:s.i+1,total:s.total,in_marker:true,marker:s.marker+chars[s.i],multipliers:s.multipliers}
  WHEN s.in_marker AND chars[s.i]=')' THEN
    head([parts IN [split(s.marker,'x')] |
      head([take IN [toInteger(parts[0])] | head([rep IN [toInteger(parts[1])] |
        {i:s.i+1,total:s.total,in_marker:false,marker:'',
         multipliers:s.multipliers+[{end_at:s.i+1+take,mult:rep}]}])])])
  ELSE
    head([am IN [reduce(m=1,mp IN s.multipliers | CASE WHEN s.i<mp.end_at THEN m*mp.mult ELSE m END)] |
      {i:s.i+1,total:s.total+am,in_marker:false,marker:'',
       multipliers:[mp IN s.multipliers WHERE s.i+1<mp.end_at]}])
  END
).total

RETURN p1 AS part1, p2 AS part2

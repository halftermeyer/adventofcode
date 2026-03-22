// AoC 2017 Day 6: Memory Reallocation
// CS: Cycle detection (seen states) | Graph: none

CYPHER 25
LET banks = [n IN split($data, '\t') WHERE size(trim(n)) > 0 | toInteger(trim(n))]
LET n = size(banks)

LET result = reduce(s={banks:banks, seen:[], steps:0, done:false, cycle:0}, _ IN range(1, 20000) |
  CASE WHEN s.done THEN s ELSE
    head([key IN [reduce(k='', b IN s.banks | k+toString(b)+',') ] |
      CASE WHEN key IN s.seen THEN
        {banks:s.banks, seen:s.seen, steps:s.steps, done:true,
         cycle: s.steps - coll.indexOf(s.seen, key)}
      ELSE
        head([maxVal IN [reduce(mx=0, b IN s.banks | CASE WHEN b>mx THEN b ELSE mx END)] |
          head([maxIdx IN [reduce(mi=-1, i IN range(0,n-1) |
            CASE WHEN s.banks[i]=maxVal AND mi=-1 THEN i ELSE mi END)] |
            head([redistributed IN [reduce(st={b:s.banks[0..maxIdx]+[0]+s.banks[maxIdx+1..], rem:maxVal, pos:(maxIdx+1)%n}, step IN range(1, maxVal) |
              {b: st.b[0..st.pos]+[st.b[st.pos]+1]+st.b[st.pos+1..],
               rem: st.rem-1,
               pos: (st.pos+1)%n}
            ).b] |
              {banks:redistributed, seen:s.seen+[key], steps:s.steps+1, done:false, cycle:0}
            ])
          ])
        ])
      END
    ])
  END
)

RETURN result.steps AS part1, result.cycle AS part2

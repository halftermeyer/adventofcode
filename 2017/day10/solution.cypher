// AoC 2017 Day 10: Knot Hash
// CS: Circular list reversal + XOR hash | Graph: none

CYPHER 25
LET input = trim($data)
LET sz = 256

// Part 1: single round with comma-separated lengths
LET lengths1 = [n IN split(input, ',') | toInteger(trim(n))]

LET p1state = reduce(s={list:range(0,sz-1), pos:0, skip:0}, len IN lengths1 |
  head([indices IN [[i IN range(0,len-1) | (s.pos+i)%sz]] |
    head([vals IN [[s.list[indices[i]] | i IN range(0,len-1)]] |
      head([rev IN [coll.reverse(vals)] |
        head([newList IN [reduce(l=s.list, j IN range(0,len-1) |
          l[0..indices[j]]+[rev[j]]+l[indices[j]+1..]
        )] | {list:newList, pos:(s.pos+len+s.skip)%sz, skip:s.skip+1}])
      ])
    ])
  ])
)

LET part1 = p1state.list[0] * p1state.list[1]

// Part 2: 64 rounds with ASCII lengths + suffix
LET hexChars = split('0123456789abcdef', '')
LET ascii_lengths = [ch IN split(input,'') | coll.indexOf(split(' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~',''), ch)+32]
LET suffix = [17,31,73,47,23]
LET lengths2 = ascii_lengths + suffix
LET allLengths = reduce(acc=[], r IN range(1,64) | acc+lengths2)

LET p2state = reduce(s={list:range(0,sz-1), pos:0, skip:0}, len IN allLengths |
  head([indices IN [[i IN range(0,len-1) | (s.pos+i)%sz]] |
    head([vals IN [[s.list[indices[i]] | i IN range(0,len-1)]] |
      head([rev IN [coll.reverse(vals)] |
        head([newList IN [reduce(l=s.list, j IN range(0,len-1) |
          l[0..indices[j]]+[rev[j]]+l[indices[j]+1..]
        )] | {list:newList, pos:(s.pos+len+s.skip)%sz, skip:s.skip+1}])
      ])
    ])
  ])
)

LET sparse = p2state.list
LET dense = [block IN range(0,15) |
  reduce(x=0, i IN range(block*16, block*16+15) | apoc.bitwise.op(x, 'XOR', sparse[i]))]

LET part2 = reduce(hex='', d IN dense |
  hex + hexChars[d/16] + hexChars[d%16])

RETURN part1, part2

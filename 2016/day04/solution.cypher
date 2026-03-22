// AoC 2016 Day 4: Security Through Obscurity
// CS: Frequency analysis + Caesar cipher | Graph: none

CYPHER 25
LET rooms = [l IN split($data, '\n') WHERE size(l) > 0 |
  head([parts IN [split(l, '[')] |
    head([cs IN [replace(parts[1], ']', '')] |
      head([ns IN [split(parts[0], '-')] |
        {name: reduce(s='', p IN ns[0..-1] | s+p), sector: toInteger(ns[-1]), checksum: cs,
         full_name: reduce(s='', p IN ns[0..-1] | s+p+'-')}])])])]

LET alpha = 'abcdefghijklmnopqrstuvwxyz'
LET valid = [r IN rooms WHERE
  head([top5 IN [reduce(s='', i IN range(0,4) | s+reduce(best={ch:'',cnt:-1},
    c IN [x IN [ch IN split(alpha,'') | {ch:ch, cnt:size([c IN split(r.name,'') WHERE c=ch])}] WHERE NOT x.ch IN split(s,'') AND x.cnt>0] |
    CASE WHEN c.cnt>best.cnt OR (c.cnt=best.cnt AND c.ch<best.ch) THEN c ELSE best END).ch
  )] | top5 = r.checksum])]

LET part1 = reduce(s=0, r IN valid | s+r.sector)
LET decrypted = [r IN valid |
  head([name IN [reduce(s='', ch IN split(r.full_name,'') |
    s+CASE WHEN ch='-' THEN ' ' ELSE split(alpha,'')[(coll.indexOf(split(alpha,''),ch)+r.sector)%26] END
  )] | {name:name, sector:r.sector}])]
LET part2 = head([r IN decrypted WHERE r.name CONTAINS 'northpole' | r.sector])

RETURN part1, part2

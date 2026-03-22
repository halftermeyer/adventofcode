// AoC 2015 Day 11: Corporate Policy
// CS: constrained search | Graph: none
// Password increment + validation via reduce()

CYPHER 25
LET input = $data

// Convert password to list of char codes
LET codes = [ch IN split(input, '') | toInteger(char_code(ch))]

// Increment function: reduce right-to-left with carry
// Then validate: straight of 3, no i/o/l, two pairs
// Iterate until valid

LET forbidden = [toInteger(char_code('i')), toInteger(char_code('o')), toInteger(char_code('l'))]

LET result = reduce(s = {pw: codes, found: false, count: 0}, _ IN range(1, 10000000) |
  CASE WHEN s.found AND s.count >= 2 THEN s ELSE
    // Increment password
    head([incremented IN [reduce(
      inc = {pw: s.pw, carry: 1},
      idx IN range(0, size(s.pw)-1) |
      head([pos IN [size(s.pw) - 1 - idx] |
        head([newVal IN [inc.pw[pos] + inc.carry] |
          CASE WHEN newVal > 122
            THEN {pw: [j IN range(0, size(inc.pw)-1) | CASE WHEN j = pos THEN 97 ELSE inc.pw[j] END], carry: 1}
            ELSE {pw: [j IN range(0, size(inc.pw)-1) | CASE WHEN j = pos THEN newVal ELSE inc.pw[j] END], carry: 0}
          END
        ])
      ])
    ).pw] |
      // Skip forbidden chars: if any forbidden char found, set it to next and zero out rest
      head([cleaned IN [reduce(cl = incremented, fi IN range(0, size(incremented)-1) |
        CASE WHEN cl[fi] IN forbidden
          THEN [j IN range(0, size(cl)-1) | CASE WHEN j < fi THEN cl[j] WHEN j = fi THEN cl[j]+1 ELSE 97 END]
          ELSE cl END
      )] |
        // Validate
        head([hasStraight IN [any(i IN range(0, size(cleaned)-3) WHERE cleaned[i+1] = cleaned[i]+1 AND cleaned[i+2] = cleaned[i]+2)] |
          head([noForbidden IN [NOT any(c IN cleaned WHERE c IN forbidden)] |
            head([pairs IN [reduce(p = {count: 0, skip: false, prev: -1}, i IN range(0, size(cleaned)-2) |
              CASE WHEN p.skip THEN {count: p.count, skip: false, prev: cleaned[i]}
              WHEN cleaned[i] = cleaned[i+1] AND cleaned[i] <> p.prev
                THEN {count: p.count + 1, skip: true, prev: cleaned[i]}
              ELSE {count: p.count, skip: false, prev: cleaned[i]} END
            ).count] |
              CASE WHEN hasStraight AND noForbidden AND pairs >= 2
                THEN {pw: cleaned, found: true, count: s.count + 1}
                ELSE {pw: cleaned, found: false, count: s.count}
              END
            ])
          ])
        ])
      ])
    ])
  END
)

RETURN [ch IN result.pw | char(ch)] AS part1
// Run twice: first result is part1, then use part1 as input for part2

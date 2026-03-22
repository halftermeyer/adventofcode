// AoC 2018 Day 8 — Memory Maneuver (both parts)
// Stack-based tree parser: Part 1 = sum metadata, Part 2 = root value

CYPHER 25
LET nums = [n IN split($data, ' ') WHERE size(n) > 0 | toInteger(n)]

LET result = reduce(
  s = {pos: 0, stack: [], meta_sum: 0, phase: 'header', root_value: 0},
  _ IN range(1, size(nums)) |
  CASE WHEN s.pos >= size(nums) THEN s
  WHEN s.phase = 'header' THEN
    head([nc IN [nums[s.pos]] |
      head([nm IN [nums[s.pos + 1]] |
        CASE WHEN nc = 0 THEN
          head([meta IN [nums[(s.pos+2)..(s.pos+2+nm)]] |
            head([meta_total IN [reduce(ms = 0, m IN meta | ms + m)] |
              head([new_stack IN [
                CASE WHEN size(s.stack) > 0 THEN
                  [ix IN range(0, size(s.stack)-1) |
                    CASE WHEN ix = size(s.stack)-1 THEN
                      {children_left: s.stack[-1].children_left - 1,
                       meta_count: s.stack[-1].meta_count,
                       child_values: s.stack[-1].child_values + [meta_total]}
                    ELSE s.stack[ix] END
                  ]
                ELSE s.stack END
              ] |
                {pos: s.pos + 2 + nm, stack: new_stack, meta_sum: s.meta_sum + meta_total,
                 phase: CASE WHEN size(new_stack) > 0 AND new_stack[-1].children_left > 0 THEN 'header'
                        WHEN size(new_stack) > 0 THEN 'meta'
                        ELSE 'done' END,
                 root_value: CASE WHEN size(new_stack) = 0 THEN meta_total ELSE s.root_value END}
              ])
            ])
          ])
        ELSE
          {pos: s.pos + 2,
           stack: s.stack + [{children_left: nc, meta_count: nm, child_values: []}],
           meta_sum: s.meta_sum, phase: 'header', root_value: s.root_value}
        END
      ])
    ])
  WHEN s.phase = 'meta' THEN
    head([top IN [s.stack[-1]] |
      head([meta IN [nums[s.pos..(s.pos + top.meta_count)]] |
        head([meta_total IN [reduce(ms = 0, m IN meta | ms + m)] |
          head([node_value IN [reduce(v = 0, m IN meta |
            v + CASE WHEN m >= 1 AND m <= size(top.child_values) THEN top.child_values[m-1] ELSE 0 END
          )] |
            head([popped IN [s.stack[0..-1]] |
              head([new_stack IN [
                CASE WHEN size(popped) > 0 THEN
                  [ix IN range(0, size(popped)-1) |
                    CASE WHEN ix = size(popped)-1 THEN
                      {children_left: popped[-1].children_left - 1,
                       meta_count: popped[-1].meta_count,
                       child_values: popped[-1].child_values + [node_value]}
                    ELSE popped[ix] END
                  ]
                ELSE popped END
              ] |
                {pos: s.pos + top.meta_count, stack: new_stack, meta_sum: s.meta_sum + meta_total,
                 phase: CASE WHEN size(new_stack) > 0 AND new_stack[-1].children_left > 0 THEN 'header'
                        WHEN size(new_stack) > 0 THEN 'meta'
                        ELSE 'done' END,
                 root_value: CASE WHEN size(new_stack) = 0 THEN node_value ELSE s.root_value END}
              ])
            ])
          ])
        ])
      ])
    ])
  ELSE s END
)

RETURN result.meta_sum AS part1, result.root_value AS part2

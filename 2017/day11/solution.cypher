// AoC 2017 Day 11: Hex Ed
// CS: Hex grid (cube coordinates) | Graph: none

CYPHER 25
LET steps = [s IN split(trim($data), ',') | trim(s)]

LET result = reduce(s={x:0, y:0, z:0, maxDist:0}, step IN steps |
  head([dx IN [CASE step WHEN 'n' THEN 0 WHEN 's' THEN 0 WHEN 'ne' THEN 1 WHEN 'sw' THEN -1 WHEN 'nw' THEN -1 WHEN 'se' THEN 1 ELSE 0 END] |
    head([dy IN [CASE step WHEN 'n' THEN 1 WHEN 's' THEN -1 WHEN 'ne' THEN 0 WHEN 'sw' THEN 0 WHEN 'nw' THEN 1 WHEN 'se' THEN -1 ELSE 0 END] |
      head([dz IN [CASE step WHEN 'n' THEN -1 WHEN 's' THEN 1 WHEN 'ne' THEN -1 WHEN 'sw' THEN 1 WHEN 'nw' THEN 0 WHEN 'se' THEN 0 ELSE 0 END] |
        head([nx IN [s.x+dx] | head([ny IN [s.y+dy] | head([nz IN [s.z+dz] |
          head([dist IN [(abs(nx)+abs(ny)+abs(nz))/2] |
            {x:nx, y:ny, z:nz, maxDist: CASE WHEN dist>s.maxDist THEN dist ELSE s.maxDist END}
          ])])])])
      ])
    ])
  ])
)

RETURN (abs(result.x)+abs(result.y)+abs(result.z))/2 AS part1, result.maxDist AS part2

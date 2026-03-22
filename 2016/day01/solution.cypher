// AoC 2016 Day 1: No Time for a Taxicab
// CS: Grid walk + visited set | Graph: none

CYPHER 25
LET moves = [m IN split($data, ', ') | {turn: left(m, 1), dist: toInteger(substring(m, 1))}]
LET dx = [0, 1, 0, -1]
LET dy = [1, 0, -1, 0]

LET p1 = reduce(s = {x: 0, y: 0, dir: 0}, m IN moves |
  head([nd IN [(s.dir + CASE m.turn WHEN 'R' THEN 1 ELSE 3 END) % 4] |
    {x: s.x + dx[nd] * m.dist, y: s.y + dy[nd] * m.dist, dir: nd}
  ])
)

LET p2 = reduce(s = {x: 0, y: 0, dir: 0, visited: ['0,0'], found: null}, m IN moves |
  CASE WHEN s.found IS NOT NULL THEN s ELSE
    head([nd IN [(s.dir + CASE m.turn WHEN 'R' THEN 1 ELSE 3 END) % 4] |
      reduce(s2 = {x: s.x, y: s.y, dir: nd, visited: s.visited, found: s.found}, step IN range(1, m.dist) |
        CASE WHEN s2.found IS NOT NULL THEN s2 ELSE
          head([nx IN [s2.x + dx[nd]] | head([ny IN [s2.y + dy[nd]] |
            head([key IN [toString(nx)+','+toString(ny)] |
              CASE WHEN key IN s2.visited
                THEN {x:nx, y:ny, dir:nd, visited:s2.visited, found:abs(nx)+abs(ny)}
                ELSE {x:nx, y:ny, dir:nd, visited:s2.visited+[key], found:null} END
            ])])])
        END)
    ]) END
)

RETURN abs(p1.x)+abs(p1.y) AS part1, p2.found AS part2

// AoC 2018 Day 20 — A Regular Map
// Build graph from regex, find farthest room
// Requires graph writes: :Room nodes, :DOOR relationships

// Step 1: Clean and set up constraint
MATCH (n) DETACH DELETE n;
CREATE CONSTRAINT room_xy IF NOT EXISTS FOR (r:Room) REQUIRE (r.x, r.y) IS NODE KEY;

// Step 2: Parse regex and build graph
CYPHER 25
LET regex = replace(replace($data, '^', ''), '$', '')
LET chars = split(regex, '')

LET result = reduce(
  s = {x: 0, y: 0, stack: [], edges: []},
  ch IN chars |
  CASE ch
    WHEN 'N' THEN head([ny IN [s.y - 1] |
      {x: s.x, y: ny, stack: s.stack, edges: s.edges + [{x1:s.x,y1:s.y,x2:s.x,y2:ny}]}])
    WHEN 'S' THEN head([ny IN [s.y + 1] |
      {x: s.x, y: ny, stack: s.stack, edges: s.edges + [{x1:s.x,y1:s.y,x2:s.x,y2:ny}]}])
    WHEN 'E' THEN head([nx IN [s.x + 1] |
      {x: nx, y: s.y, stack: s.stack, edges: s.edges + [{x1:s.x,y1:s.y,x2:nx,y2:s.y}]}])
    WHEN 'W' THEN head([nx IN [s.x - 1] |
      {x: nx, y: s.y, stack: s.stack, edges: s.edges + [{x1:s.x,y1:s.y,x2:nx,y2:s.y}]}])
    WHEN '(' THEN {x: s.x, y: s.y, stack: s.stack + [{x: s.x, y: s.y}], edges: s.edges}
    WHEN ')' THEN {x: s.stack[-1].x, y: s.stack[-1].y, stack: s.stack[0..-1], edges: s.edges}
    WHEN '|' THEN {x: s.stack[-1].x, y: s.stack[-1].y, stack: s.stack, edges: s.edges}
    ELSE s
  END
)

UNWIND result.edges AS e
MERGE (r1:Room {x: e.x1, y: e.y1})
MERGE (r2:Room {x: e.x2, y: e.y2})
MERGE (r1)-[:DOOR]->(r2)
RETURN count(*) AS edges_created;

// Step 3: Find shortest paths
CYPHER 25
MATCH (origin:Room {x: 0, y: 0})
MATCH (target:Room) WHERE target <> origin
MATCH path = shortestPath((origin)-[:DOOR*]-(target))
WITH length(path) AS dist
WITH max(dist) AS part1, collect(dist) AS all_dists
RETURN part1, size([d IN all_dists WHERE d >= 1000]) AS part2

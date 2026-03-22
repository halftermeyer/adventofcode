// AoC 2018 Day 6 — Chronal Coordinates (both parts)
// Manhattan distance Voronoi + total distance region

CYPHER 25
LET coords = [line IN split($data, '\n') WHERE size(line) > 0 |
  {x: toInteger(split(line, ', ')[0]), y: toInteger(split(line, ', ')[1])}
]
LET min_x = reduce(m = 9999, c IN coords | CASE WHEN c.x < m THEN c.x ELSE m END)
LET max_x = reduce(m = 0, c IN coords | CASE WHEN c.x > m THEN c.x ELSE m END)
LET min_y = reduce(m = 9999, c IN coords | CASE WHEN c.y < m THEN c.y ELSE m END)
LET max_y = reduce(m = 0, c IN coords | CASE WHEN c.y > m THEN c.y ELSE m END)
RETURN coords, min_x, max_x, min_y, max_y

NEXT

UNWIND range(min_x, max_x) AS gx
UNWIND range(min_y, max_y) AS gy
WITH coords, min_x, max_x, min_y, max_y, gx, gy,
  [ix IN range(0, size(coords)-1) | {ix: ix, dist: abs(coords[ix].x - gx) + abs(coords[ix].y - gy)}] AS dists
WITH coords, min_x, max_x, min_y, max_y, gx, gy, dists,
  reduce(m = 9999, d IN dists | CASE WHEN d.dist < m THEN d.dist ELSE m END) AS min_dist
WITH coords, min_x, max_x, min_y, max_y, gx, gy,
  [d IN dists WHERE d.dist = min_dist] AS closest,
  reduce(s = 0, d IN dists | s + d.dist) AS total_dist
WITH min_x, max_x, min_y, max_y, gx, gy,
  CASE WHEN size(closest) = 1 THEN closest[0].ix ELSE -1 END AS owner,
  total_dist
WITH min_x, max_x, min_y, max_y,
  collect(CASE WHEN owner >= 0 THEN {owner: owner, border: gx = min_x OR gx = max_x OR gy = min_y OR gy = max_y} END) AS cells,
  sum(CASE WHEN total_dist < 10000 THEN 1 ELSE 0 END) AS part2
WITH cells, part2,
  coll.distinct([c IN cells WHERE c IS NOT NULL AND c.border | c.owner]) AS infinite_owners
WITH part2,
  [c IN cells WHERE c IS NOT NULL AND NOT c.owner IN infinite_owners | c.owner] AS finite_cells
UNWIND finite_cells AS owner
WITH part2, owner, count(*) AS area
ORDER BY area DESC
LIMIT 1
RETURN area AS part1, part2

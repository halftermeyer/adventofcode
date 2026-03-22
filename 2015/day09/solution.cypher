// AoC 2015 Day 9: All in a Single Night — TSP via graph
// Graph: (:City)-[:ROAD {dist}]->(:City)

CYPHER 25
LET edges = [line IN split($data, '\n') WHERE size(line) > 0 |
  head([parts IN [split(line, ' ')] |
    {f: parts[0], t: parts[2], dist: toInteger(parts[4])}
  ])
]

UNWIND edges AS e
MERGE (a:City {name: e.f}) MERGE (b:City {name: e.t})
CREATE (a)-[:ROAD {dist: e.dist}]->(b)
CREATE (b)-[:ROAD {dist: e.dist}]->(a)
RETURN count(*) AS _

NEXT

MATCH (c1:City)-[r1:ROAD]->(c2:City)-[r2:ROAD]->(c3:City)-[r3:ROAD]->(c4:City)
      -[r4:ROAD]->(c5:City)-[r5:ROAD]->(c6:City)-[r6:ROAD]->(c7:City)-[r7:ROAD]->(c8:City)
WHERE c1<>c2 AND c1<>c3 AND c1<>c4 AND c1<>c5 AND c1<>c6 AND c1<>c7 AND c1<>c8
  AND c2<>c3 AND c2<>c4 AND c2<>c5 AND c2<>c6 AND c2<>c7 AND c2<>c8
  AND c3<>c4 AND c3<>c5 AND c3<>c6 AND c3<>c7 AND c3<>c8
  AND c4<>c5 AND c4<>c6 AND c4<>c7 AND c4<>c8
  AND c5<>c6 AND c5<>c7 AND c5<>c8 AND c6<>c7 AND c6<>c8 AND c7<>c8
WITH r1.dist+r2.dist+r3.dist+r4.dist+r5.dist+r6.dist+r7.dist AS total
ORDER BY total
WITH collect(total) AS dists
RETURN dists[0] AS part1, dists[-1] AS part2

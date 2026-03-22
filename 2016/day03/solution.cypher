// AoC 2016 Day 3: Squares With Three Sides
// CS: Sorting / validation | Graph: none

CYPHER 25
LET lines = [l IN split($data, '\n') WHERE size(l) > 0]
LET triangles = [l IN lines | coll.sort([n IN split(l, ' ') WHERE size(n) > 0 | toInteger(n)])]
LET part1 = size([t IN triangles WHERE t[0]+t[1]>t[2]])

LET raw = [l IN lines | [n IN split(l, ' ') WHERE size(n) > 0 | toInteger(n)]]
LET col_triangles = reduce(acc=[], g IN range(0, size(raw)/3-1) |
  acc + [coll.sort([raw[g*3][0],raw[g*3+1][0],raw[g*3+2][0]]),
         coll.sort([raw[g*3][1],raw[g*3+1][1],raw[g*3+2][1]]),
         coll.sort([raw[g*3][2],raw[g*3+1][2],raw[g*3+2][2]])])
LET part2 = size([t IN col_triangles WHERE t[0]+t[1]>t[2]])

RETURN part1, part2

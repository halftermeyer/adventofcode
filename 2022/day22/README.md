# Day 22: Monkey Map
[Problem](https://adventofcode.com/2022/day/22) | **Graph**: Toroidal Grid (P1) / Cube Surface Graph (P2) | **CS**: 2D navigation with wrapping / cube net folding

## Graph Model

### Part 1 — Toroidal Grid

```
GRAPH TYPE ToroidalGrid {
  (Tile {x INT, y INT, tile STRING})
  (Tile)-[RIGHT]->(Tile)   // horizontal (wraps: last→first per row)
  (Tile)-[DOWN]->(Tile)    // vertical (wraps: last→first per column)

  (Step {ix INT, val ANY, type STRING})  // "walk" or "rotate"
  (Step)-[NEXT]->(Step)

  (Direction {sym STRING, type STRING, val INT})  // ">", "v", "<", "^"
  (Direction)-[ROTATE {val: 'R'|'L'}]->(Direction)  // 4-node cycle
}
```

The grid is a **torus**: each row's last tile links RIGHT back to its first, each column's last links DOWN back to its first. Walking N steps is a single `apoc.path.expandConfig` — wrapping is baked into the topology.

The direction state is itself a **4-node cycle graph**: `> →R→ v →R→ < →R→ ^ →R→ >`. No if/else — just traverse the ROTATE edge.

### Part 2 — Cube Surface Graph

The flat grid is partitioned into 50×50 faces. Instead of toroidal wrapping, faces are connected along their cube edges using three colored relationship systems.

```
GRAPH TYPE CubeSurface {
  (Tile {x INT, y INT, X INT, Y INT})
  // X,Y = face coordinates (which of the 6 faces)

  // Three colored relationship systems — one per cube axis:
  (Tile)-[GREEN]->(Tile)   // vertical cube axis
  (Tile)-[BLUE]->(Tile)    // another axis
  (Tile)-[BLACK]->(Tile)   // horizontal cube axis

  // Inside each face: tiles linked by two of the three colors
  // Across face boundaries: boundary tiles stitched by zipping unconnected edges

  (CubeDirection {type STRING, natural BOOLEAN})
  (Direction {sym STRING, type STRING, natural BOOLEAN, val INT})
  (CubeDirection)-[SAME_AS {X INT, Y INT}]->(Direction)
  // Maps cube directions to cardinal directions PER FACE
}
```

**Key insight**: A cube face has two internal directions. These correspond to two of the three colored relationship types. The `SAME_AS` relationship maps between the cube's intrinsic directions and the cardinal directions (RIGHT/DOWN/LEFT/UP), **parameterized by face** via `{X, Y}` properties on the relationship.

When you walk off one face, `apoc.path.expandConfig` follows the colored relationship onto the adjacent face. The `SAME_AS` graph tells you your new cardinal direction. No hard-coded direction tables — the cube topology IS the graph.

## Approach

### Part 1
1. Parse tiles, create `RIGHT` and `DOWN` links within rows/columns
2. **Wrap edges** to create torus: `CREATE (last)-[:DOWN]->(first)` per column
3. Remove wall tiles (`#`), leaving only walkable tiles connected
4. Parse path into `Step` chain, create direction cycle graph
5. Simulate: iterate via `apoc.periodic.commit`, walk via `apoc.path.expandConfig`

### Part 2
1. Same tile parsing, but NO toroidal wrapping
2. Assign face coordinates: `(t.x-1)/50 + 1` → `t.X`
3. Build intra-face links using GREEN/BLUE/BLACK
4. **Stitch cube edges**: find unconnected boundary tiles per face pair (`WHERE NOT EXISTS {(t)-[:GREEN]->()}`), zip them together in matching order
5. Create `CubeDirection -[:SAME_AS {X,Y}]-> Direction` mapping per face
6. Simulate: walk along colored relationships, use `SAME_AS` for direction across face transitions

## Why This Is Special

Most Day 22 Part 2 solutions hard-code a direction lookup table for each face transition. This solution **encodes the cube topology declaratively in the graph**:

- Three colored relationship types = three cube axes
- Face stitching via pattern matching on unconnected boundary tiles
- Direction mapping across faces is a graph traversal (`CubeDirection -[:SAME_AS]-> Direction`)
- Walking across a face boundary is indistinguishable from walking within a face

The cube IS the graph. The code doesn't need to know it's on a cube — it just follows relationships.

## Key Techniques

- **Toroidal wrapping** via `CREATE (last)-[:DOWN]->(first)` — wrapping is graph topology
- **Direction as graph**: 4-node ROTATE cycle eliminates conditional turning logic
- **Three-color cube encoding**: GREEN/BLUE/BLACK as cube axes
- **Boundary stitching**: `WHERE NOT EXISTS {()-[:COLOR]->(t)}` finds unstitched edges
- **`SAME_AS` per-face direction mapping**: cube direction → cardinal direction as graph lookup
- **`apoc.path.expandConfig`**: walk N steps regardless of face boundaries
- **`apoc.periodic.commit` + `apoc.cypher.runMany`**: iterative step execution

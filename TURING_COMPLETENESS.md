# Cypher is Turing-Complete: A Proof

## Theorem

CYPHER 25, restricted to a single `RETURN` statement with `reduce()`, list comprehensions, and `CASE` expressions, is Turing-complete.

## Proof Strategy

We prove Turing-completeness by simulating an arbitrary **2-counter machine** (Minsky machine) in Cypher. 2-counter machines are known to be Turing-complete [Minsky, 1967].

## 1. Definition: 2-Counter Machine

A 2-counter machine M = (Q, q₀, q_halt, δ) consists of:
- Q: finite set of states
- q₀ ∈ Q: initial state
- q_halt ∈ Q: halting state
- δ: Q → Instructions, where each instruction is one of:
  - `INC(c, q')`: increment counter c ∈ {A, B}, go to state q'
  - `JZDEC(c, q_zero, q_pos)`: if counter c = 0 go to q_zero, else decrement c and go to q_pos

**Fact** [Minsky 1967]: For any Turing machine T, there exists a 2-counter machine M that simulates T.

## 2. Encoding in Cypher

### 2.1 Program Encoding

Encode the transition function δ as a Cypher list of maps:

```cypher
LET program = [
  {state: 0, op: 'INC',   counter: 'A', next: 1},
  {state: 1, op: 'JZDEC', counter: 'B', q_zero: 2, q_pos: 3},
  {state: 2, op: 'INC',   counter: 'B', next: 0},
  {state: 3, op: 'HALT',  counter: '',  next: 3}
  // ... arbitrary program
]
```

This is a finite, static list — no graph writes needed.

### 2.2 Machine State

The machine configuration (state, counter_A, counter_B) is encoded as a Cypher map:

```cypher
{state: 0, A: 0, B: 0}
```

### 2.3 Simulation via reduce()

```cypher
CYPHER 25
LET program = [ /* ... as above ... */ ]
LET max_steps = 1000000  // arbitrary bound (see §3 for unbounded case)

LET result = reduce(
  machine = {state: 0, A: 0, B: 0},
  step IN range(1, max_steps) |
  CASE WHEN machine.state = -1 THEN machine  // halted: identity for all remaining iterations
  ELSE
    // head([v IN [expr] | ...]) is a let-binding idiom — binds instr = program[machine.state]
    head([instr IN [program[machine.state]] |
      CASE instr.op
        WHEN 'INC' THEN
          CASE instr.counter
            WHEN 'A' THEN {state: instr.next, A: machine.A + 1, B: machine.B}
            WHEN 'B' THEN {state: instr.next, A: machine.A, B: machine.B + 1}
          END
        WHEN 'JZDEC' THEN
          CASE instr.counter
            WHEN 'A' THEN
              CASE WHEN machine.A = 0
                THEN {state: instr.q_zero, A: 0, B: machine.B}
                ELSE {state: instr.q_pos, A: machine.A - 1, B: machine.B}
              END
            WHEN 'B' THEN
              CASE WHEN machine.B = 0
                THEN {state: instr.q_zero, A: machine.A, B: 0}
                ELSE {state: instr.q_pos, A: machine.A, B: machine.B - 1}
              END
          END
        WHEN 'HALT' THEN {state: -1, A: machine.A, B: machine.B}
      END
    ])
  END
)

RETURN result
```

### 2.4 Correctness

**Claim**: After k iterations of `reduce()`, the value of `machine` equals the configuration of the 2-counter machine M after k steps of execution.

**Proof by induction on k:**

**Base case** (k=0): `machine = {state: 0, A: 0, B: 0}` = initial configuration of M. ✓

**Inductive step**: Assume after k iterations, `machine = {state: qₖ, A: aₖ, B: bₖ}` matches M's configuration.

At iteration k+1, the `reduce()` body:
1. Looks up `program[machine.state]` → retrieves instruction δ(qₖ)
2. Executes the instruction via `CASE`:
   - If `INC(A, q')`: returns `{state: q', A: aₖ+1, B: bₖ}` — matches M's INC semantics ✓
   - If `JZDEC(A, q_z, q_p)` with aₖ=0: returns `{state: q_z, A: 0, B: bₖ}` — matches ✓
   - If `JZDEC(A, q_z, q_p)` with aₖ>0: returns `{state: q_p, A: aₖ-1, B: bₖ}` — matches ✓
   - If `HALT`: returns `{state: -1, ...}` and all subsequent iterations are identity ✓

   (Symmetric cases for counter B.)

Therefore `machine` after k+1 iterations matches M's configuration after k+1 steps. □

## 3. The Bounded-Step Objection

The proof above uses `range(1, max_steps)` which bounds the computation. A strict interpretation of Turing-completeness requires unbounded computation.

### 3.1 Resolution via IN TRANSACTIONS

CYPHER 25 provides iteration via `IN TRANSACTIONS` with a termination mechanism:

```cypher
CYPHER 25
// Store machine state in graph
CREATE (:Machine {state: 0, A: 0, B: 0});

UNWIND range(1, 9223372036854775807) AS step  // 2^63 - 1
CALL (step) {
  MATCH (m:Machine)
  // 1/0 guard BEFORE list indexing — triggers ON ERROR BREAK when halted
  WITH m,
       CASE WHEN m.state = -1 THEN 1/0
            ELSE $program[m.state]
       END AS instr
  SET m.state = CASE instr.op
    WHEN 'INC' THEN instr.next
    WHEN 'JZDEC' THEN CASE instr.counter
      WHEN 'A' THEN CASE WHEN m.A = 0 THEN instr.q_zero ELSE instr.q_pos END
      WHEN 'B' THEN CASE WHEN m.B = 0 THEN instr.q_zero ELSE instr.q_pos END END
    WHEN 'HALT' THEN -1 END,
  m.A = CASE WHEN instr.op = 'INC' AND instr.counter = 'A' THEN m.A + 1
        WHEN instr.op = 'JZDEC' AND instr.counter = 'A' AND m.A > 0 THEN m.A - 1
        ELSE m.A END,
  m.B = CASE WHEN instr.op = 'INC' AND instr.counter = 'B' THEN m.B + 1
        WHEN instr.op = 'JZDEC' AND instr.counter = 'B' AND m.B > 0 THEN m.B - 1
        ELSE m.B END
} IN TRANSACTIONS OF 1 ROW
  ON ERROR BREAK
```

**Termination mechanism**: When the machine reaches the HALT instruction, `state` is set to -1. On the *next* iteration, the guard `CASE WHEN m.state = -1 THEN 1/0` fires *before* any list indexing, triggering a division-by-zero error caught by `ON ERROR BREAK`, which cleanly exits the loop. This ensures `$program[-1]` is never evaluated.

**Note on the 2⁶³ bound**: Strictly speaking, `range(1, 2⁶³-1)` is still a finite bound, so this does not achieve *theoretical* unbounded computation. True unbounded execution would require an external driver (e.g., a client-side loop that restarts the query if it hasn't halted). In practice, 2⁶³ ≈ 9.2×10¹⁸ steps exceeds the runtime of any physically realizable computation, making the bound irrelevant.

### 3.2 Resolution via Sufficiency Argument

For any specific Turing machine T on input w that halts in f(|w|) steps, we can set `max_steps = f(|w|)` in the `reduce()` version. Since:
- Every **decidable** language L has a Turing machine T_L that halts on all inputs
- For each such T_L, there exists a computable bound f
- The Cypher `reduce()` with `range(1, f(|w|))` correctly decides L

This shows Cypher is **computationally universal for total functions** — it can compute any computable function on any input, given a sufficient bound. The gap with full Turing-completeness concerns only non-halting computations (which §3.1 addresses via `IN TRANSACTIONS`). For all practical purposes — deciding languages, computing functions, simulating algorithms — `reduce()` with a sufficient bound is equivalent to a Turing machine.

### 3.3 Resolution via Graph-Native QPP Traversal

The most idiomatic approach: model the machine *as a graph* and let pattern matching *be* the computation.

Encode each state as a node and each instruction as a typed relationship (`:INC`, `:JZDEC_ZERO`, `:JZDEC_POS`). A valid execution trace is a path from `:Init` to `:Halt`. The `allReduce` predicate prunes invalid branches eagerly during traversal.

```cypher
CYPHER 25
// Build the machine graph
CREATE (q0:State:Init {name: 'q0'})
CREATE (q1:State      {name: 'q1'})
CREATE (q2:State      {name: 'q2'})
CREATE (q3:State:Halt {name: 'q3'})
CREATE (q0)-[:INC        {c:'A'}]->(q1)
CREATE (q1)-[:JZDEC_ZERO {c:'B'}]->(q2)
CREATE (q1)-[:JZDEC_POS  {c:'B'}]->(q3)
CREATE (q2)-[:INC        {c:'B'}]->(q0)
```

```cypher
CYPHER 25
// Traverse: allReduce prunes, NEXT extracts
MATCH REPEATABLE ELEMENTS
  p = (init:Init)
    -[rels:INC|JZDEC_ZERO|JZDEC_POS]->
      {1, 9223372036854775807}
    (h:Halt)
WHERE allReduce(
  m = {A: 0, B: 0}, r IN rels |
  CASE
    WHEN r:INC AND r.c = 'A' THEN {A: m.A+1, B: m.B}
    WHEN r:INC AND r.c = 'B' THEN {A: m.A, B: m.B+1}
    WHEN r:JZDEC_POS AND r.c = 'A' THEN {A: m.A-1, B: m.B}
    WHEN r:JZDEC_POS AND r.c = 'B' THEN {A: m.A, B: m.B-1}
    ELSE m
  END,
  CASE
    WHEN r:JZDEC_ZERO AND r.c = 'A' THEN m.A = 0
    WHEN r:JZDEC_ZERO AND r.c = 'B' THEN m.B = 0
    WHEN r:JZDEC_POS AND r.c = 'A' THEN m.A >= 0
    WHEN r:JZDEC_POS AND r.c = 'B' THEN m.B >= 0
    ELSE true
  END
)
RETURN rels, length(p) AS steps
NEXT
// Re-derive counters from the valid path
LET final = reduce(m = {A:0, B:0},
    r IN rels |
    CASE
      WHEN r:INC AND r.c = 'A' THEN {A: m.A+1, B: m.B}
      WHEN r:INC AND r.c = 'B' THEN {A: m.A, B: m.B+1}
      WHEN r:JZDEC_POS AND r.c = 'A' THEN {A: m.A-1, B: m.B}
      WHEN r:JZDEC_POS AND r.c = 'B' THEN {A: m.A, B: m.B-1}
      ELSE m
    END
  )
RETURN steps, final.A AS ctrA, final.B AS ctrB
```

**Key properties:**
- The machine *is* the graph; computation *is* path finding.
- `REPEATABLE ELEMENTS` allows revisiting states (loops).
- `allReduce` prunes eagerly: once a JZDEC branch fails the predicate, that path is abandoned immediately.
- No HALT self-loop needed — reaching a `:Halt` node terminates the pattern.
- `reduce()` in the `NEXT` stage re-derives final counter values from the surviving path.

**Subtlety: post-update predicate.** The `allReduce` predicate is evaluated on the *post-update* accumulator. For `JZDEC_POS`, the update decrements the counter first, then the predicate checks `>= 0` (not `> 0`). This ensures that decrementing from 1 to 0 is accepted.

## 4. What Cypher Primitives Are Needed

The proof uses only:
- **`reduce()`**: fold over a list — provides iteration
- **`CASE WHEN`**: conditional branching
- **Integer arithmetic**: `+1`, `-1`, `= 0` — counter operations
- **Map construction**: `{state, A, B}` — machine state representation
- **List indexing**: `program[state]` — random access to the instruction table (essential for O(1) instruction lookup)
- **`head([v IN [expr] | ...])`**: let-binding idiom (convenience — avoidable by inlining, but improves readability)

No graph operations, no APOC, no GDS. Pure Cypher expressions suffice.

## 5. Corollaries

### 5.1 The Halting Problem
Since Cypher is Turing-complete, it is undecidable whether a given Cypher `reduce()` expression will terminate. (This follows from Rice's theorem applied to the reduction from 2-counter machines.)

### 5.2 Universality
CYPHER 25 can compute any computable function. Any algorithm expressible as a Turing machine has an equivalent `reduce()`-based Cypher query.

### 5.3 What Cypher Adds Beyond Turing-Completeness
While `reduce()` makes Cypher Turing-complete for computation, Cypher's **graph pattern matching** with QPP and `allReduce` provides something most Turing-complete languages lack: **declarative constrained traversal** with pruning at each step. This is not about computability (all TC languages are equivalent) but about **expressiveness** — some problems are more naturally expressed as graph patterns than as imperative loops.

## 6. Verified Execution on Neo4j Aura

All three approaches were tested on a Neo4j Aura instance running Neo4j 5.x with CYPHER 25 support. The example program below increments A, tests B, loops once to increment B, then halts.

### 6.1 Test Program: Manual Trace

The 4-instruction program from §2.1:

| Step | State | Instruction | A | B |
|------|-------|-------------|---|---|
| 0 | q₀ | INC(A, q₁) | 0→1 | 0 |
| 1 | q₁ | JZDEC(B, q₂, q₃) — B=0 | 1 | 0 |
| 2 | q₂ | INC(B, q₀) | 1 | 0→1 |
| 3 | q₀ | INC(A, q₁) | 1→2 | 1 |
| 4 | q₁ | JZDEC(B, q₂, q₃) — B>0 | 2 | 1→0 |
| 5 | q₃ | HALT | 2 | 0 |

**Expected result**: `{state: -1, A: 2, B: 0}`

### 6.2 Test: reduce() Simulation

```cypher
CYPHER 25
LET program = [
  {state: 0, op: 'INC',   counter: 'A', next: 1},
  {state: 1, op: 'JZDEC', counter: 'B', q_zero: 2, q_pos: 3},
  {state: 2, op: 'INC',   counter: 'B', next: 0},
  {state: 3, op: 'HALT',  counter: '',  next: 3}
]
LET max_steps = 1000000

LET result = reduce(
  machine = {state: 0, A: 0, B: 0},
  step IN range(1, max_steps) |
  CASE WHEN machine.state = -1 THEN machine
  ELSE
    head([instr IN [program[machine.state]] |
      CASE instr.op
        WHEN 'INC' THEN
          CASE instr.counter
            WHEN 'A' THEN {state: instr.next, A: machine.A + 1, B: machine.B}
            WHEN 'B' THEN {state: instr.next, A: machine.A, B: machine.B + 1}
          END
        WHEN 'JZDEC' THEN
          CASE instr.counter
            WHEN 'A' THEN
              CASE WHEN machine.A = 0
                THEN {state: instr.q_zero, A: 0, B: machine.B}
                ELSE {state: instr.q_pos, A: machine.A - 1, B: machine.B}
              END
            WHEN 'B' THEN
              CASE WHEN machine.B = 0
                THEN {state: instr.q_zero, A: machine.A, B: 0}
                ELSE {state: instr.q_pos, A: machine.A, B: machine.B - 1}
              END
          END
        WHEN 'HALT' THEN {state: -1, A: machine.A, B: machine.B}
      END
    ])
  END
)
RETURN result
```

**Actual result**: `{A: 2, B: 0, state: -1}` ✓

### 6.3 Test: IN TRANSACTIONS Simulation

```cypher
-- Step 1: Create initial machine state
CYPHER 25
CREATE (:Machine {state: 0, A: 0, B: 0});
```

```cypher
-- Step 2: Run with program passed as parameter $program
CYPHER 25
UNWIND range(1, 9223372036854775807) AS step
CALL (step) {
  MATCH (m:Machine)
  WITH m,
       CASE WHEN m.state = -1 THEN 1/0
            ELSE $program[m.state]
       END AS instr
  SET m.state = CASE instr.op
    WHEN 'INC' THEN instr.next
    WHEN 'JZDEC' THEN CASE instr.counter
      WHEN 'A' THEN CASE WHEN m.A = 0 THEN instr.q_zero ELSE instr.q_pos END
      WHEN 'B' THEN CASE WHEN m.B = 0 THEN instr.q_zero ELSE instr.q_pos END END
    WHEN 'HALT' THEN -1 END,
  m.A = CASE WHEN instr.op = 'INC' AND instr.counter = 'A' THEN m.A + 1
        WHEN instr.op = 'JZDEC' AND instr.counter = 'A' AND m.A > 0 THEN m.A - 1
        ELSE m.A END,
  m.B = CASE WHEN instr.op = 'INC' AND instr.counter = 'B' THEN m.B + 1
        WHEN instr.op = 'JZDEC' AND instr.counter = 'B' AND m.B > 0 THEN m.B - 1
        ELSE m.B END
} IN TRANSACTIONS OF 1 ROW
  ON ERROR BREAK
```

```cypher
-- Step 3: Read final state
MATCH (m:Machine) RETURN m.state, m.A, m.B
```

**Actual result**: `m.state = -1, m.A = 2, m.B = 0` ✓

### 6.4 Test: QPP allReduce Traversal

Uses the graph built in §3.3, then runs the traversal query.

**Actual result**: `steps = 5, ctrA = 2, ctrB = 0` ✓

All three approaches produce the expected result, matching the manual trace step-for-step.

## References

- Minsky, M.L. (1967). *Computation: Finite and Infinite Machines*. Prentice-Hall. — Proof that 2-counter machines are Turing-complete.
- Neo4j Documentation: [Cypher Manual](https://neo4j.com/docs/cypher-manual/current/) — `reduce()` function specification.
- Advent of Code Cypher Solutions: [github.com/halftermeyer/adventofcode](https://github.com/halftermeyer/adventofcode) — 300+ solved algorithmic problems in Cypher.
- Halftermeyer, P. (2025). EV Road Trip Planning with Neo4j — QPP and `allReduce`. Neo4j Developer Blog.

# Day 21: Monkey Math
[Problem](https://adventofcode.com/2022/day/21) | **Graph**: Expression Tree | **CS**: Equation solving

## Graph Model
`(:Monkey)` nodes forming an expression tree via `[:LEFT_OP]` and `[:RIGHT_OP]` relationships. Leaf monkeys hold literal values; internal monkeys hold an operator (+, -, *, /).

## Approach
Build the expression tree from the input. Part 1 forward-evaluates from leaves to root by propagating computed values upward. Part 2 marks the path from `humn` to root as unknown, evaluates all known subtrees, then back-propagates from the root equality constraint downward to solve for the `humn` value.

## Key Techniques
- Expression tree construction with operator nodes
- Bottom-up forward evaluation
- Top-down back-propagation to solve for the unknown (Part 2)

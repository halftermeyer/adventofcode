# Day 13: Packet Scanners
[Problem](https://adventofcode.com/2017/day/13) | **Graph**: None | **CS**: Modular arithmetic
## Approach
Each scanner at depth d with range r cycles with period 2*(r-1). A packet entering at time t is caught at layer d if (t+d) % (2*(r-1)) == 0. Part 1: sum d*r for all caught layers at t=0. Part 2: find smallest delay t where no layer catches.
## Answers
| Part | Answer |
|------|--------|
| 1 | 1876 |
| 2 | 3964778 |

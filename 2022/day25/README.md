# Day 25: Full of Hot Air
[Problem](https://adventofcode.com/2022/day/25) | **Graph**: None | **CS**: Base conversion

## Graph Model
None — pure functional. SNAFU numbers are processed as strings with digit-by-digit arithmetic.

## Approach
Parse each SNAFU number (balanced base-5 with digits `=`, `-`, `0`, `1`, `2` representing -2 through 2) into decimal, sum all values, then convert the result back to SNAFU. The conversion works digit-by-digit from least significant: compute the remainder, pick the SNAFU digit, and carry as needed.

## Key Techniques
- SNAFU-to-decimal conversion via positional expansion
- Decimal-to-SNAFU conversion with carry propagation
- Balanced base-5 digit mapping (`=`=-2, `-`=-1, `0`=0, `1`=1, `2`=2)

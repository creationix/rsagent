# Grapnel

## High Level Properties:

- Combination of real OS threads and green-threads for optimal effeciency.
- No shared state between functions except for parameters in and out.
- Internal scheduler automatically schedules optimally.

- Optional typing and type inference for safty and performance.
- Traits instead of classes for saner OOP.

- Uniform, elegant iteration and looping construct.

- avoids need for mutation of values and prefers functional style.

## Primitives:

- number (64 bit integer and 64+64 bit rational)
- boolean (true/false)
- symbol (interned string for quick symbolic comparisons)

## Collections:

- Map (HashMap - unordered keys)
- Set (essentially map where all values are true)
- List (Linked List)
- String (mutable cons list of unicode characters)
- Buffer (same as string, but for bytes instead of characters)

## Traits / Objects:

- Like map, but symbol to value mapping and static shaped.  Shape is interned.
- Trait holds default values, but values may be replaced locally with same type.
- An object can have multiple traits so long as public keys don't conflict.

## Function:

- A function is a block of code that accepts named, positional, and out arguments.
- There is no shared state between functions other than explicitly passed values.
- arguments have type and optional default values.

## Loops:

- Iteration in the form `for k v in value:` or `for v in value:`.
  - Iterating over integer gives key and value of 0 to value - 1.
  - Iterating over map gives key/value pairs.
  - Iterating over lists gives index/value pairs.
  - Iterating over string gives index/charcode pairs.
  - Iterating over byte array gives index/byte pairs.
- Optional `with var value` fold using initial value and last value of iterations.
- Optional `when cond` after loop to filter out certain values.
- `for ... in` results in last value of last loop if no `into ...` is present.

## Basic Operators:

add, sub, mul, div, idiv, mod, neg (numbers in and out)
gt, gte, lt, lte, eq, neq (same type and comparable in, boolean out)
and, or, xor, not (anything in (note anything not `false` is truthy), preserved value out)
get, set (same key/value semantics as iteration, works for string, buffer, list, map, object)
remove (works on maps/sets only)
union, difference, intersect (maps/sets only)
add-trait, remove-trait, has-trait (objects)

## Type Conversions:

string-to-symbol: in string, out symbol
symbol-to-string: in symbol, out string
string-to-set-symbol: in string, in set<symbol>, out symbol, throws not-in-set
string-to-buffer: in string, out buffer (utf-8 encoding)
buffer-to-string: in buffer, out string (utf-8-decoding), throws invalid-utf8-byte
buffer-to-list: in buffer, out list
list-to-buffer: in list, out buffer, throws invalid value
string-to-list: in string, out list
list-to-string: in list, out string, throws invalid value
set-to-list: in set, out list
list-to-set: in list, out set
zip(lists-to-map): in key-list, in value-list, out map, throws list-length-mismatch
unzip(map-to-lists): in map, out key-list, out value-list
object-to-map: in object, in list<traits>, out map
map-to-object: in map, in list<traits>, out map, throws trait-key-collision

## Syntax:

- python-like significant whitespace.  Heavy IDE assistance.
- infix notation for common operators.

Example: Find the sum of all the multiples of 3 or 5 below 1000.

```grapnel
for i in 1000
    with sum 0
    when (i % 3 = 0) or (i % 5 = 0):
  sum + i
```

Example: Print the x and y coordinates of all black tiles in a chess board.

```grapnel
for y in 8
    x in 8
    when ((x + y) % 2) = 0:
  print x y
```


Example: By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

```grapnel
def fibsum a=1 b=2 sum=0:
  if a >= 4000000:
    return sum
  if a % 2 == 0:
    return fibsum b (a + b) (sum + a)
  return fibsum b (a + b) sum
fibsum
```

# Opcodes

The core language is stored on disk in an s-expression like bytecode.  Front-end
syntaxes need to be able to convert to and from this format without any loss.

## Numerical Operations

- Addition - `("+" 1 2)` - Adds 2 numbers.
- Subtraction - `("-" 2 1)` - Subtracts numbers.
- Multiplication - `("*" 1 2)` - Multiplies 2 numbers.
- Division - `("/" 1 2)` - Divides two numbers (may result in rational)
- Integer Division - `("\" 1 2)` - Divides two numbers as integer
- Modulus - `("%" 1 2)` - Divides two numbers, keep result

## Comparison Operations

- Equal - `("=" a b)` - checks for equality of 2 values
- Not Equal - `("!=" a b)` - Inverse of Equal.
- Greater Than - `(">" a b)` - compare 2  values.
- Less Than - `("<" a b)` - compare 2  values.
- Greater Than or Equal - `(">=" a b)` - compare 2  values.
- Less Than or Equal - `("<=" a b)` - compare 2  values.

## Logical Operations

- And - `("and" a b)` - checks 2 values to see if both are true. returns last
  truthy value. (lazy evaluation)
- Or - `("or" a b)` - checks 2 values to see if either is true. returns first
  truthy value. (lazy evaluation)
- Xor - `("xor" a b)` - checks 2 values.  Returns one value it it's the only
  trutht value.
- Not - `("not" a)` - inverts value logic

## Conditional Operations

- If..elif..else - `("if" [condition (block)]+ (block)?)` - Lazy evaluation of
  the conditions and blocks.  Last block is else.
- Switch - `("switch" expression [value (block)]+ (block)?)` - Like If, except
  expression is evaluated only once and checked for equality with matches.

## Loops

- For..in - `("for" (expression ident+) (block) (block)?)` - Iterate over
  expression result.  Optional block runs if loop exits on own (not break)
- While - `("while" expression (block) (block)?)` - Repeatedly evaluate
  expression and block till expression is false.
- Forever - `("forever" (block))` - Run block forever (till break)
- Break - `("break")` - Exit loop skipping optional after section.
- Continue - `("continue")` - Jump to top of loop

## Functions

- Function - `("fun" (receiver) (block))` - Create a function instance.
- Return - `("return" (sender))` - early return from function body.
- Call - `("call" expression (sender)*)` - Call a function with zero or more
  senders which are combined into a single argument list.

## Variables

- Assign - `("set" (receiver) (sender))` - Set local variables
- Set - `("set" identifier expression)` - Update reference to a single variable.
- Get - `("get" identifier)` - Dereference a local variable

## String/Buffer/List Operations

 - IGet - `("iget" list index)` - Get a value from a list at index
 - ISet - `("iset" list index value)` - Set a value to a list at index.
 - Sub - `("sub" list start end)` - return sublist of same type
 - Concat - `("cat" a b)` - Concatenate two lists to a new list
 - Push - `("push" list value)` - Push value onto list.
 - Pop - `("push" list)` - Pop value from list.
 - Unshift - `("unshift" list value)` - Insert value to front of list.
 - Shift - `("shift" list)` - Remove first value from list.
 - Split - `("split" list separator)` - Split list into sublists.
 - Join - `("join" list separator)` - Combine sublists into single list
 - toString - `("tostring" value)` - Convert buffer to utf-8 decoded string.
   Convert list of codepoints to string.
 - toBuffer - `("tobuffer" value)` - Convert string to utf-8 encoded buffer.
   Convert list of bytes to buffer.
 - toList - `("tolist" value)` - Convert string to list of codepoints, buffer
   to list of bytes.
 - TODO: add more useful operations

## Map Operations

 - mGet - `("mget" map key)` - Same as iGet, but for maps
 - mSet - `("mset" map key value)` - Same as iSet, but for maps

## Iterators

 - Range - `("range" num)` - Return an iterator from 0 to value - 1.
 - Pairs - `("pairs" map)` - Return an iterator for k, v of map pairs.
 - Items - `("items" list)` - Return an iterator for items in a list.
 - PopIter - `("popiter" list)` - Pop items from list till nothing is left.
 - ShiftIter - `("shiftiter" list)` - Shift items from list till nothing is left.

## Iterator transforms

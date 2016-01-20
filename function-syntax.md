Grapnel uses a universal tuple syntax for function arguments and return values.

Calling a function is done by simply placing an single expression after the
function expression.

```grapnel
// A single argument doesn't need any parens.
print "Hello World"
// But you can use them
print ("Hello Verbose World")
// They are required for zero argument calls.
beep ()
// Multiple arguments can be achieved by passing in a tuple with multiple values
writeFile ("config.txt", "Hello File\n")
```

Any time you have a tuple of exactly one value, the parens are optional.

Also pipe syntax can be used for nice transform pipelines.

```grapnel
fun doubleSay(str) {
  str + ", " + str
}
fun capitalize(str) {
  str[0].toUpperCase() + str.substring(1)
}
fun exclaim(str) {
  str + '!'
}
"hello" | doubleSay | capitalize | exclaim
```

Return values are implicit since move everything is an expression and returns a
value.

There are two kinds of tuple syntaxes, the sending and receiving.  Sending is
simply zero or more expressions separated by commas.  The expressions can be
labeled or positional.

Receiving tuples contains variable names, optional types, optional labels, and
optional default values.

```grapnel
(a, b) = (b, a) // Can be used to swap variables.

// Box returns a tuple with a named property of `name`, but we want a local
// variable of `boxName`.
fun loadBox() {
  // Return tuple with named members
  (name="FooBox", size=100)
}
(name as boxName) = loadBox()

// Default values make all arguments optional
fun newFox(name="Foxy",age=3) {
  print "a fox is born"
}
// We pass in just he second argument using a named argument.
newFox(age=100)
```

var PEG = require("pegjs");
var FS = require('fs');

var parser = PEG.buildParser(FS.readFileSync("parser.pegjs", "utf8"));

// console.log(parser.parse("1+2"));
// console.log(parser.parse("1*2"));

var inspect = require('util').inspect;

function p() {
  return console.log.apply(console.log, [].map.call(arguments, function (i) {
    return inspect(i, {depth:100,colors:true});
  }));
}


function test(code) {
  console.log("\n" + code);
  return p(parser.parse(code));
}

test("(a, b) := (b, a)");
test("(1, 2) | print");
test("5 | print");
test("print()");
test("(x) := ()");
// test("(name, age) := loadUser(id)");
test("42 | double | print");
test("():=1");
test("x:=1");

test("def fib n {\n" +
// "  if n = 0 { } \n" +
"  \n" +
"}")
// // p(parser.parse("(a):=1"));
// p(parser.parse("a:=1"));
// p(parser.parse("(a,b):=1"));
// p(parser.parse("(a,b,c):=1"));
// p(parser.parse("(a,b,c,d):=1"));
// //
// // p(parser.parse("a:=1+2+3"));
// // p(parser.parse("1+2*3"));
// // p(parser.parse("1*2+3"));
// // p(parser.parse("1*(2+3)"));

/*
a , b - comma operator (left to right)

a := b - assignment (right to left)

a or/xor b - logical or (left to right)

a and b - logical and (left to right)

a =/≠ b - comparision (left to right)

a </<=/>/>= b - comparison (left to right)

a +/- b - add/subtract (left to right)

a * / % b - mul-div/mod (left to right)

not a / -/+ a - (right to left)

( a ) - function call (left to right)
a . b - property lookup (left to right)

*/

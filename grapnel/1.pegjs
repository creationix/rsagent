
start
  = E0

E0
  = rest:(E1 _ "," _)+ v:E1 { return rest.map(pick0).concat([v]); }
  / E1

E1
  = left:E2 _ ":=" _ right:E1 { return {receiver:left,sender:right}; }
  / left:E2 _ "|" _ right:E1 { return {receiver:right,sender:left}; }
  / E2

E2
  = rest:(E3 _ ("or"/"xor") _)+ v:E3 { return leftAssoc(rest, v); }
  / E3

E3
  = rest:(E4 _ "and" _)+ v:E4 { return leftAssoc(rest, v); }
  / E4

E4
  = rest:(E5 _ ("="/"≠"/"!=") _)+ v:E5 { return leftAssoc(rest, v); }
  / E5

E5
  = rest:(E6 _ ("<"/"≤"/"<="/">"/"≥"/">=") _)+ v:E6 { return leftAssoc(rest, v); }
  / E6

E6
  = rest:(E7 _ ("+"/"-") _)+ v:E7 { return leftAssoc(rest, v); }
  / E7

E7
  = rest:(E8 _ ("*"/"×"/"/"/"÷"/"%") _)+ v:E8 { return leftAssoc(rest, v); }
  / E8

E8
  = operator:("not"/"-"/"+") right:E9 { return {operator:operator,right:right}}
  / E9

E9
  = rest:(E10 _ "." _)+ v:E10 { return leftAssoc(rest, v); }
  / E10

E10
  = "(" value:E0 ")" { return value; }
  / Integer
  / Identifier

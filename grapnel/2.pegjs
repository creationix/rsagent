/*

sender
  = "(" _ ")" { return []; }
  / one: expression { return [one]; }
  / "(" _ a:expression _ "," _ b:expression _ c:("," _ expression _)* ")" {
    return [a,b].concat(c.map(pick2));;
  }

receiver
  = "(" _ ")" { return []; }
  / id: identifier { return [id]; }
  / "(" _ a:identifier _ "," _ b:identifier _ c:("," _ identifier _)* ")" {
    return [a,b].concat(c.map(pick2));;
  }


expression
  = sender:sender _ "|" _ target:identifier {
    return { sender: sender, target: target}
  }
  / binop1

binop1

binop2
  = rest:(primary _ [*/] _)* v:primary { return leftAssoc(rest, v); }
  / primary

primary
  = integer
  / call
  / identifier
  / "(" _ expression:expression _ ")" { return expression; }

call
  = fn:identifier _ args:sender {
    return {fn:fn,args:args}
  }

integer
  = digits:[0-9]+ { return makeInteger(digits); }

*/

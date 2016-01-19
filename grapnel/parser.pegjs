{
  function makeInteger(o) {
    return parseInt(o.join(""), 10);
  }
  function leftAssoc(rest, val) {
      if (!rest.length) return val;
      var last = rest.pop();
      return {left:leftAssoc(rest, last[0]), operator:last[2], right:val};
  }
  function rightAssoc(val, rest) {
      if (!rest.length) return val;
      var first = rest.shift();
      return {left:val, operator:first[0], right:rightAssoc(first[2], rest)};
  }
  function pick0(i) { return i[0]; }
  function pick1(i) { return i[1]; }
  function pick2(i) { return i[2]; }
  function pick3(i) { return i[3]; }
}

start
 = Statement+

Statement
 = Assign
 / Call
 / Pipe
 / Return
 / Def

Def
  = "def" __ i:Identifier _ r:Receiver _ "{" _ b:Statement* _ "}" {
    return ["DEF", i, r, b];
  }

Assign
  = r:Receiver _ ":=" _ s:Sender { return ["ASSIGN", r, s]; }

Call
  = f:Identifier _ s:Sender { return ["CALL", f[1], s]; }

Pipe
  = v:Sender r:(_ "|" _ Identifier)+ { return ["PIPE", v].concat(r.map(pick3).map(pick1)); }

Return
  = "return" _ v:Sender { return ["RETURN", v]; }

Sender
  = "(" _ ")" { return []; }
  / "(" _ l:(Expression _ "," _)* v:Expression _ ")" {
    return l.map(pick0).concat([v]);
  }
  / v:Expression { return [v]; }

Receiver
  = "(" _ l:(Identifier _ "," _)* i:Identifier _ ")" {
    return l.map(pick0).map(pick1).concat([i[1]]);
  }
  / id:Identifier { return [id[1]]; }

Expression
  = Integer
  / Identifier

Integer
  = digits:[0-9]+ { return makeInteger(digits); }

Identifier
  = id:([a-zA-Z][a-zA-Z0-9_]*) {
    return [ "GET", [id[0]].concat(id[1]).join("") ];
  }

// optional whitespace
_  = [ \t\r\n]*

// mandatory whitespace
__  = [ \t\r\n]+

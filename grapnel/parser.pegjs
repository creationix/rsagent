{
  function makeInteger(o) {
    return parseInt(o.join(""), 10);
  }
  function leftAssoc(rest, val) {
      if (!rest.length) return val;
      var last = rest.pop();
      return [last[2], leftAssoc(rest, last[0]), val];
  }
  function rightAssoc(val, rest) {
      if (!rest.length) return val;
      var first = rest.shift();
      return [first[0], val, rightAssoc(first[2], rest)];
  }
  function pick0(i) { return i[0]; }
  function pick1(i) { return i[1]; }
  function pick2(i) { return i[2]; }
  function pick3(i) { return i[3]; }
}

start
 = Statement+

Statement
 = Def
 / Namespace
 / Return
 / Pipe
 / Let
 / If
 / Expression

Block = "{" _ b:Statement* _ "}" { return b; }

Def = "def" __ i:Reference _ r:Receiver _ b:Block {
  return ["DEF", i[1], r, b];
}

Namespace = "namespace" __ i:Reference _ b:Block {
  return ["NAMESPACE", i[1], b];
}

Import = "import" __ i:Reference {
  return ["IMPORT", i];
}

If = "if" __ i:Expression _ b:Block _ elif:("elif" __ Expression _ Block _)* e:("else" _ Block)? {
  var tag = ["IF", i, b];
  elif.forEach(function (m) {
    tag.push(m[2], m[4]);
  });
  if (e) tag.push(e[2]);
  return tag;
}

For = "for" __ m:Identifier s:(_ "," _ Identifier)? _ "in" _ e:Expression b:Block {
  
}

Return = "return" _ v:Sender { return ["RETURN", v]; }

Pipe = v:Sender r:(_ "|" _ Identifier)+ {
  return ["PIPE", v].concat(r.map(pick3).map(pick1));
}

Let
  = "let" __ r:Receiver _ ":=" _ s:Sender {
    return ["LET", r, s];
  }
  / "let" __ r:Receiver {
    return ["LET", r, false];
  }

Expression
  = Assign
  / Call
  / E0

Assign
  = r:Receiver _ ":=" _ s:Sender { return ["ASSIGN", r, s]; }

Call
  = f:Reference _ s:Sender { return ["CALL", f[1], s]; }

Sender
  = "(" _ ")" { return []; }
  / "(" _ l:(Expression _ "," _)* v:Expression _ ")" {
    return l.map(pick0).concat([v]);
  }
  / v:Expression { return [v]; }

Receiver
  = "(" _ list:(Identifier (_ "=" _ Expression)? _ "," _)* id:Identifier  d:(_ "=" _ Expression)?_ ")" {
    var params = list.map(function (item) {
      if (item[1] && item[1][3] !== undefined) {
        return [item[0],item[1][3]];
      }
      return item[0];
    });
    if (d && d[3] !== undefined) {
      params.push([id,d[3]]);
    }
    else {
      params.push(id);
    }
    return params;
  }
  / id:Identifier { return [id]; }

E0
  = rest:(E1 _ ("+"/"-") _)* v:E1 { return leftAssoc(rest, v); }
  / E1

E1
  = rest:(E2 _ ("*"/"/"/"%") _)* v:E2 { return leftAssoc(rest, v); }
  / E2

E2
  = Integer
  / Boolean
  / Reference
  / "(" v:Expression ")" { return v; }

Integer = digits:[0-9]+ { return makeInteger(digits); }

Boolean = b:("true"/"false") { return b === "true"; }

Identifier = id:([a-zA-Z][a-zA-Z0-9_]*) {
  return [id[0]].concat(id[1]).join("");
}

Reference = prefix:(Identifier ".")* id:Identifier {
  return ["GET", prefix.concat([id])];
}

// optional whitespace
_ = [ \t\r\n]*

// mandatory whitespace
__ = [ \t\r\n]+

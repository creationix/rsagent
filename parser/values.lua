local ffi = require 'ffi'

ffi.cdef[[
  typedef struct rational {
    int64_t num;
    int64_t dem;
  } rational_t;
]]



function newInteger(val)
  return ffi.new("int64_t", val)
end
function newRational(num, dem)
  local r = ffi.new("rational_t")
  r.num = num
  r.dem = dem
  return r
end

function add(a, b)
  if (type(a) == "number" or (type(a) == "cdata" and ffi.typeof(a) == "ctype<int64_t>")) and
     (type(b) == "number" or (type(b) == "cdata" and ffi.typeof(b) == "ctype<int64_t>")) then
   return a + b
 end
 p{a=a,b,b}
end

p(add(1, 2))
p(add(1ll, 2))
p(add(1, 2ll))
p(add(1ll, 2ll))
p(add(1, newRational(1, 3)))
i = newInteger(42)
r = newRational(1, 3)
p(i, r)
p(ffi.typeof(i))
p(ffi.typeof(r))

--
-- Nil,
-- True,
-- False,
-- Integer(i64),
-- Rational(i64, i64),
-- String(Rc<String>),
-- Buffer(Rc<bytes::Buf>),
-- Pair(Rc<(Value, Value)>),
-- BTreeMap(Rc<collections::BTreeMap<Value, Value>>),
-- BTreeSet(Rc<collections::BTreeSet<Value>>),
-- BinaryHeap(Rc<collections::BinaryHeap<Value>>),
-- HashMap(Rc<collections::HashMap<Value, Value>>),
-- HashSet(Rc<collections::HashSet<Value>>),
-- LinkedList(Rc<collections::LinkedList<Value>>),
-- VecDeque(Rc<collections::VecDeque<Value>>),

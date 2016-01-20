local setTimeout = require('timer').setTimeout

local function sortedInsert(sorted, item)
  local next = sorted[2]
  if not next or item < next[1] then
    sorted[2] = {item, next}
  else
    sortedInsert(next, item)
  end
end

local function innerSort(sorted, list)
  p(sorted, list)
  -- When we reach the end of the list, we're done
  if not list then
    return sorted
  end

  -- Insert the value
  local item = list[1]
  if not sorted or item < sorted[1] then
    sorted = {item, sorted}
  else
    sortedInsert(sorted, item)
  end

  -- And iterate on the list
  innerSort(sorted, list[2])
  return
end

-- Sort a lisp-style cons list into a new list.
local function sort(list)
  return innerSort(nil, list)
end

list = nil
for i = 1, 10 do
  list = {math.random(100),list}
end

p(sort(list))

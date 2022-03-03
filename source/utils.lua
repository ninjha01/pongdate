function smoothMove(sprite, x, y)
   local xSign = x > 1 and 1 or -1
   local ySign = y > 1 and 1 or -1

   for i=1, math.abs(x) do
      sprite:moveBy(xSign, 0)
   end
   for i=1, math.abs(y) do
      sprite:moveBy(0, ySign)
   end
end

function table.slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced+1] = tbl[i]
  end

  return sliced
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

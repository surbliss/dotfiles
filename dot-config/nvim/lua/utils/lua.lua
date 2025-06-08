local M = {}

-- To use for checking a value is one of multiple values at once.
-- See https://www.lua.org/pil/11.5.html
M.set = function(list)
   local set = {}
   for _, l in ipairs(list) do
      set[l] = true
   end
   return set
end

M.is_ts_nodes = function(node, node_list)
   if type(node_list) == "string" then node_list = { node_list } end
   local node_set = M.set(node_list)
   -- Utilize short-ciruiting for safe type check
   return node ~= nil and node_set[node:type()]
end

return M

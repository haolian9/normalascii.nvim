local ffi = require("ffi")

--points to normalascii.nvim/
local root = (function()
  -- thanks to bfredl for this solution: https://github.com/neovim/neovim/issues/20340#issuecomment-1257142131
  local source = debug.getinfo(1, "S").source
  assert(vim.startswith(source, "@") and vim.endswith(source, "c.lua"), "failed to resolve the root dir of normalascii.nvim")
  return vim.fn.fnamemodify(string.sub(source, 2), ":h:h:h")
end)()

ffi.cdef([[
  int stay_in_ascii_mode();
]])

_ = ffi.load(string.format("%s/%s/lib%s.so", root, "zig-out/lib", "normalascii"), true)

return ffi.C

local M = {}

local C = require("normalascii.c")
local api = vim.api

local log = (function()
  local opts = { source = "normalascii.nvim" }

  local function maker(level)
    return function(fmt, ...)
      vim.notify(string.format(fmt, ...), level, opts)
    end
  end

  return {
    debug = maker(vim.log.levels.DEBUG),
    info = maker(vim.log.levels.INFO),
    err = maker(vim.log.levels.ERROR),
  }
end)()

local dbus_available = os.getenv("DISPLAY") ~= nil

function M.goto_ascii()
  if not dbus_available then return log.err("not in GUI env") end

  ---@diagnostic disable: undefined-field
  if C.stay_in_ascii_mode() ~= 1 then log.err("failed to set rime to ascii mode") end
end

function M.auto_ascii()
  if not dbus_available then return log.err("not in GUI env") end

  -- todo: ModeChanged? ctrl-c
  api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
      M.goto_ascii()
    end,
  })
end

return M

---@type MappingsTable
local M = {}


M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action({apply=true})
      end,
      "code action"
    }
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M

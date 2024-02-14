local M = {
  "abecodes/tabout.nvim",
  event = "VeryLazy",
}

M.config = function()
  require("tabout").setup {
    tabkey = "<Tab>",
    act_as_tab = true, -- fallback to tab, if `tabout` action is not available
    pairs = { ---@type ntab.pair[]
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "<", close = ">" },
    },
    exclude = {},
  }
end

return M

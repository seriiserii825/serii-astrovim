return {
  n = {
    ["b"] = { "<Plug>Sneak_S", desc = "Sneak back" },
    ["<M-l>"] = { ":wa<CR>", desc = "close all" },
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
  },
  i = {
    ["<C-i"] = { "<Plug>copilot#Accept('<CR>')" }
  }
}

return {
  n = {
    ["<leader>q"] = { "<cmd>q<cr>", desc = "Quit" },
    ["b"] = { "<Plug>Sneak_S", desc = "Sneak back" },
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
  },
}

return {
  n = {
    ["b"] = { "<Plug>Sneak_S", desc = "Sneak back" },
    ["<M-l>"] = { ":wa<CR>", desc = "close all" },
    ["<leader>;"] = { ":vsplit<CR>", desc = "split" },
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
    ["<C-t"] = { "<cmd>copilot#Accept('<CR>')", desc = "copilot expand", silent = true },
  },
}


-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- let g:copilot_no_tab_map = v:true

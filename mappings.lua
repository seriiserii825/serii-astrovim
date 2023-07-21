local mappings =  {
  n = {
    ["[n"] = { ":set relativenumber!<CR>", desc = "Toggle relativenumber" },
    ["b"] = { "<Plug>Sneak_S", desc = "Sneak back" },
    ["<M-l>"] = { ":Format<CR>", desc = "Format" },
    ["<M-k>"] = { ":wall<CR>", desc = "Save" },
    ["<leader>a"] = { ":w  <bar> %bd <bar> e# <bar> bd# <CR>", desc = "close other" },
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
    ['<C-l>'] = { 'copilot#Accept("\\<CR>")', desc = 'copilot expand', silent = true, expr = true, script = true },
  },
}
-- Функция для удаления непечатных символов
local function removeNonPrintableChars(str)
  return str:gsub("[%z\1-\31\127-\255]", "")
end

-- Удалить непечатные символы из значений таблицы mappings
for _, mode in pairs(mappings) do
  for _, mapping in pairs(mode) do
    if type(mapping) == "table" and mapping.desc then
      mapping.desc = removeNonPrintableChars(mapping.desc)
    end
  end
end

return mappings

-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- let g:copilot_no_tab_map = v:true

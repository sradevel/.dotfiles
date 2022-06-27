-- if vim.g.snippets ~= "luasnip" or not pcall(require, "luasnip") then
--   return
-- end

local ls = require "luasnip"
require("luasnip/loaders/from_vscode").lazy_load()

ls.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

vim.keymap.set({"i", "s"}, "<C-s>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-S-s>", function()
  if ls.jumpable() then
    ls.jump(-1)
  end
end, {silent = true})

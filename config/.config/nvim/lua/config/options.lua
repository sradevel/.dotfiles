-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spelllang = "en,de"

-- additional filetype mappings
vim.filetype.add({
  -- I've organized my sshconfigs in a
  -- config.d subdirectory
  pattern = {
    [".*.ssh/config.d/.*"] = "sshconfig",
  },
  filename = {
    ["justfile"] = "make",
  },
})

-- require("config.gosnippets")

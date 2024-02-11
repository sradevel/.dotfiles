-- catpuccin colorscheme
--
return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        integrations = {
          headlines = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

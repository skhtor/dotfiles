require("lazy").setup({{ import = "sassy.plugins" }, { import = "sassy.plugins.lsp" }}, {
  install = {
    colorscheme = { "catppuccin" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

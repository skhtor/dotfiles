return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = { "%.git/" },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        additional_args = { "--hidden" },
      },
    },
  },
}

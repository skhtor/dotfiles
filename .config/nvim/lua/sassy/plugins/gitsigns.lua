return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup()

    local keymap = vim.keymap 
    keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
    keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")
  end,
}

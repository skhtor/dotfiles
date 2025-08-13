return {
	"zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true },
      panel = { enabled = true },
      filetypes = {
        markdown = true,
        terraform = true,
        sh = true,
        yaml = true,
      },
    })
  end,
}

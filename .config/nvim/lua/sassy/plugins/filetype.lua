return {
	"nathom/filetype.nvim",
	config = function()
		require("filetype").setup({
			overrides = {
				extensions = {
					tf = "terraform",
					tfvars = "terraform",
					hcl = "terraform",
					Makefile = "make",
          gotmpl = "helm",
					tfstate = "json",
					sh = "bash",
          yaml = "helm",
				},
			},
		})
	end,
}

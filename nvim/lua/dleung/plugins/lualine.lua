return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
	local lualine = require("lualine")
	local lazy_status = require("lazy.status") -- to configure lazy pending updates count
	local navic = require("nvim-navic")

	-- configure lualine with catppuccin theme
	lualine.setup({
		options = {
			theme = "catppuccin",
		},
		sections = {
			lualine_x = {
				-- {
				-- 	lazy_status.updates,
				-- 	cond = lazy_status.has_updates,
				-- 	color = { fg = "#ff9e64" },
				-- },
				-- { "encoding" },
				-- { "fileformat" },
				{ "filetype" },
			},
			lualine_c = {
				"filename",
				{ navic.get_location, cond = navic.is_available },
				{ "lsp_progress", display_components = { "lsp_client_name", { "title", "percentage", "message" } } },
			},
		},
	})
  end,
}

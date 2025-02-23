return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require("telescope").setup({
			defaults = {
				-- path_display = { "smart" },
				dynamic_preview_title = true,
				winblend = 10,
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					prompt_position = "bottom",
					height = 0.95,
				},
			},
		})
	end,
}

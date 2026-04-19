return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"hiphish/rainbow-delimiters.nvim",
		"OXY2DEV/markview.nvim",
	},
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").setup()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
		})

		require("nvim-treesitter").install({
			"bash",
			"c",
			"cmake",
			"cpp",
			"diff",
			"css",
			"dockerfile",
			"go",
			"gitcommit",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"python",
			"regex",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				if ev.match ~= "html" then
					pcall(vim.treesitter.start)
				end
			end,
		})

		local select = require("nvim-treesitter-textobjects.select")
		local function map_textobject(mode, lhs, query, desc)
			vim.keymap.set(mode, lhs, function()
				select.select_textobject(query, "textobjects")
			end, { desc = desc, silent = true, noremap = true })
		end

		for _, mode in ipairs({ "x", "o" }) do
			map_textobject(mode, "af", "@function.outer", "TS: around function")
			map_textobject(mode, "if", "@function.inner", "TS: inner function")
			map_textobject(mode, "ac", "@class.outer", "TS: around class")
			map_textobject(mode, "ic", "@class.inner", "TS: inner class")
		end

		-- This module contains a number of default definitions
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		}
	end,
}

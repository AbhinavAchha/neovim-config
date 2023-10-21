return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"SmiteshP/nvim-navic",
	},

	opts = function()
		local navic = require("nvim-navic")

		local kernel = " " .. string.match(io.popen("uname -r"):read("l"), "%d+.%d+.%d+")

		local function linux()
			return kernel
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " " },
			colored = false,
			update_in_insert = false,
			always_visible = true,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = function()
				return vim.fn.winwidth(0) > 80
			end,
		}

		local filetype = {
			"filetype",
			icons_enabled = true,
			icon = " ",
		}

		local branch = {
			"branch",
			icons_enabled = true,
			icon = "",
		}

		local location = {
			"location",
			-- padding = 0.25,
		}

		return {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { branch, diagnostics },
				lualine_b = {
					"mode",
					{
						"filename",
						file_status = true,
						path = 1,

						symbols = {
							modified = "[+]", -- when the file was modified
							readonly = "[-]", -- if the file is not modifiable or readonly
							unnamed = "[No Name]", -- default display name for unnamed buffers
						},
					},
				},
				lualine_c = {
					{ navic.get_location, cond = navic.is_available },
				},
				lualine_x = { diff, filetype },
				lualine_y = { location, linux },
				lualine_z = { "filesize" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { location },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		}
	end,
}

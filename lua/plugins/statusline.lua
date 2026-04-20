return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		-- "SmiteshP/nvim-navic",
	},

	opts = function()
		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = "󰅙 ", warn = "󰀪 " },
			colored = false,
			update_in_insert = false,
			always_visible = true,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " },
			cond = function()
				return false -- Disabled: not practical
			end,
		}

		local filetype = {
			"filetype",
			icons_enabled = true,
			icon = "󰈙 ",
		}

		local branch = {
			"branch",
			icons_enabled = true,
			icon = "",
		}

		local location = { "location" }

		local lsp_clients = {
			function()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if #clients == 0 then
					return ""
				end
				local names = vim.tbl_map(function(c)
					return c.name
				end, clients)
				return " " .. table.concat(names, ", ")
			end,
			cond = function()
				return false -- Disabled: not practical
			end,
		}

		return {
			options = {
				icons_enabled = true,
				theme = "cyberdream",
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
							modified = "[+]",
							readonly = "[-]",
							unnamed = "[No Name]",
						},
					},
				},
				lualine_c = {},
				lualine_x = { lsp_clients, diff, filetype },
				lualine_y = { location },
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
			-- winbar = {
			-- 	lualine_c = {
			-- 		{
			-- 			function()
			-- 				return require("nvim-navic").get_location()
			-- 			end,
			-- 			cond = function()
			-- 				return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
			-- 			end,
			-- 		},
			-- 	},
			-- },
			inactive_winbar = {
				lualine_c = { { "filename" } },
			},
			tabline = {},
			extensions = {},
		}
	end,
}

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local gps = require("nvim-gps")

local kernel = " " .. string.match(io.popen("uname -r"):read("l"), "%d+.%d+.%d+")

gps.setup({
	icons = {
		["class-name"] = " ",
		["function-name"] = " ",
		["method-name"] = " ",
		["container-name"] = "⛶ ",
		["tag-name"] = "炙",
	},
	separator = " > ",
})

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

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
	cond = hide_in_width,
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

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "dracula",
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
			{ gps.get_location, cond = gps.is_available },
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
})

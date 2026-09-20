local function open_location_preview(selection, parent_win)
	if not selection then
		return
	end

	local filename = selection.filename or selection.path
	if not filename then
		return
	end

	local bufnr = vim.fn.bufadd(filename)
	vim.fn.bufload(bufnr)

	if not vim.api.nvim_win_is_valid(parent_win) then
		parent_win = vim.api.nvim_get_current_win()
	end

	local parent_width = vim.api.nvim_win_get_width(parent_win)
	local parent_height = vim.api.nvim_win_get_height(parent_win)
	local width = math.max(1, math.min(120, parent_width - 4))
	local height = math.max(1, math.min(15, parent_height - 4))
	local win = vim.api.nvim_open_win(bufnr, true, {
		border = "rounded",
		col = math.floor((parent_width - width) / 2),
		height = height,
		relative = "win",
		row = math.floor((parent_height - height) / 2),
		style = "minimal",
		title = " " .. vim.fn.fnamemodify(filename, ":t") .. " ",
		title_pos = "left",
		width = width,
		win = parent_win,
	})

	vim.api.nvim_win_set_cursor(win, { selection.lnum or 1, math.max(0, (selection.col or 1) - 1) })
end

local function open_lsp_picker(items, title, parent_win)
	local telescope_opts = require("telescope.themes").get_dropdown({
		hide_preview = false,
		layout_config = { height = 15, width = 75 },
	})
	local actions = require("telescope.actions")

	require("telescope.pickers")
		.new(telescope_opts, {
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = require("telescope.actions.state").get_selected_entry()
					actions.close(prompt_bufnr)
					vim.schedule(function()
						open_location_preview(selection, parent_win)
					end)
				end)
				return true
			end,
			finder = require("telescope.finders").new_table({
				entry_maker = require("telescope.make_entry").gen_from_quickfix(telescope_opts),
				results = items,
			}),
			previewer = require("telescope.config").values.qflist_previewer(telescope_opts),
			prompt_title = title,
			sorter = require("telescope.config").values.generic_sorter(telescope_opts),
		})
		:find()
end

local function lsp_picker(method, title)
	return function()
		local parent_win = vim.api.nvim_get_current_win()
		local params = function(client)
			local position = vim.lsp.util.make_position_params(parent_win, client.offset_encoding)
			if method == "textDocument/references" then
				position.context = { includeDeclaration = true }
			end
			return position
		end

		vim.lsp.buf_request_all(0, method, params, function(results)
			local items = {}

			for client_id, response in pairs(results) do
				if response.result then
					local client = vim.lsp.get_client_by_id(client_id)
					if client then
						local locations = vim.islist(response.result) and response.result or { response.result }
						vim.list_extend(items, vim.lsp.util.locations_to_items(locations, client.offset_encoding))
					end
				end
			end

			if vim.tbl_isempty(items) then
				vim.notify("No " .. title:lower() .. " found", vim.log.levels.INFO)
			elseif #items == 1 then
				open_location_preview(items[1], parent_win)
			else
				open_lsp_picker(items, title, parent_win)
			end
		end)
	end
end

return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		-- https://github.com/adibhanna/nvim/blob/867bcb9c66ff58081e9c64d45079ff0dec6a174e/lua/plugins/telescope.lua#L273
		local function document_symbols_for_selected(prompt_bufnr)
			local action_state = require("telescope.actions.state")
			local actions = require("telescope.actions")
			local entry = action_state.get_selected_entry()

			if entry == nil then
				print("No file selected")
				return
			end

			actions.close(prompt_bufnr)

			vim.schedule(function()
				local bufnr = vim.fn.bufadd(entry.path)
				vim.fn.bufload(bufnr)

				local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

				vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, function(err, result, _, _)
					if err then
						print("Error getting document symbols: " .. vim.inspect(err))
						return
					end

					if not result or vim.tbl_isempty(result) then
						print("No symbols found")
						return
					end

					local function flatten_symbols(symbols, parent_name)
						local flattened = {}
						for _, symbol in ipairs(symbols) do
							local name = symbol.name
							if parent_name then
								name = parent_name .. "." .. name
							end
							table.insert(flattened, {
								name = name,
								kind = symbol.kind,
								range = symbol.range,
								selectionRange = symbol.selectionRange,
							})
							if symbol.children then
								local children = flatten_symbols(symbol.children, name)
								for _, child in ipairs(children) do
									table.insert(flattened, child)
								end
							end
						end
						return flattened
					end

					local flat_symbols = flatten_symbols(result)

					-- Define highlight group for symbol kind
					vim.cmd([[highlight TelescopeSymbolKind guifg=#61AFEF]])

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Document Symbols: " .. vim.fn.fnamemodify(entry.path, ":t"),
							finder = require("telescope.finders").new_table({
								results = flat_symbols,
								entry_maker = function(symbol)
									local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Other"
									return {
										value = symbol,
										display = function(entry)
											local display_text = string.format("%-50s %s", entry.value.name, kind)
											return display_text,
												{ { { #entry.value.name + 1, #display_text }, "TelescopeSymbolKind" } }
										end,
										ordinal = symbol.name,
										filename = entry.path,
										lnum = symbol.selectionRange.start.line + 1,
										col = symbol.selectionRange.start.character + 1,
									}
								end,
							}),
							sorter = require("telescope.config").values.generic_sorter({}),
							previewer = require("telescope.config").values.qflist_previewer({}),
							attach_mappings = function(_, map)
								map("i", "<CR>", function(prompt_bufnr)
									local selection = action_state.get_selected_entry()
									actions.close(prompt_bufnr)
									vim.cmd("edit " .. selection.filename)
									vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
								end)
								return true
							end,
						})
						:find()
				end)
			end)
		end
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				winblend = 12,
				layout_config = { width = 0.9, height = 0.9 },
				show_line = true,
				border = true,
				mappings = {
					i = { ["<C-s>"] = document_symbols_for_selected },
				},
			},
			pickers = {
				find_files = { winblend = 12 },
				live_grep = { winblend = 8 },
				buffers = { winblend = 0 },
			},
		})

		-- Telescope-specific highlight overrides (generic floats owned by handlers.lua)
		local function telescope_highlights()
			local bg = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false }).bg or 0x1e1e2e
			for _, grp in ipairs({
				"TelescopeNormal",
				"TelescopePromptNormal",
				"TelescopeResultsNormal",
				"TelescopePreviewNormal",
			}) do
				vim.api.nvim_set_hl(0, grp, { bg = bg, blend = 10 })
			end
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#00ff00", bg = bg })
			vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#dddddd", bg = bg })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#ff00ff", bg = bg })
			vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#ff00f0", bg = bg })
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#0000ff", bg = bg })
			vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#000fff", bg = bg })
			vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#D79921", bold = true })
			vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#D79921", bold = true })
		end

		telescope_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = telescope_highlights })

		telescope.load_extension("fzf")
	end,

	keys = {
		{ "gp", lsp_picker("textDocument/definition", "Definitions"), desc = "Preview definitions" },
		{ "<leader>i", lsp_picker("textDocument/implementation", "Implementations"), desc = "Preview implementations" },
		{ "<leader>j", lsp_picker("textDocument/references", "References"), desc = "Preview references" },
		{ "<leader>ff", ":Telescope fd<CR>" },
		{ "<leader>rg", ":Telescope live_grep<CR>" },
		{ "<leader>fgc", ":Telescope git_commits<cr>" },
		{ "<leader>fgs", ":Telescope git_status<cr>" },
		{ "<leader>fm", ":Telescope man_pages<cr>" },
		{ "<leader>/", ":Telescope search_history<cr>" },
		{ "<leader>:", ":Telescope command_history<cr>" },
		{ "<leader>k", ":Telescope keymaps<cr>" },
		{ "<leader>gs", ":Telescope grep_string<cr>" },
		{ "<leader>ds", ":Telescope lsp_document_symbols<cr>" },
		{ "<leader>dw", ":Telescope lsp_dynamic_workspace_symbols<cr>" },
		{ "<leader>bf", ":Telescope current_buffer_fuzzy_find<cr>" },
		{ "<leader>o", ":Telescope lsp_outgoing_calls<cr>" },
	},
}

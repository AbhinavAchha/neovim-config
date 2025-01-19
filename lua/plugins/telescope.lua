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
		-- https://github.com/nvim-telescope/telescope.nvim/wiki/Gallery#padded-full-menu-in-norcallis-blue
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				winblend = 10,
				layout_config = {
					width = 0.9,
					height = 0.9,
				},
				show_line = true,
				mappings = {
					i = {
						["<C-s>"] = document_symbols_for_selected,
					},
				},
			},
			builtins = {
				sort_mru = true,
			},
		})
		local TelescopePrompt = {
			TelescopePromptBorder = {
				fg = "#00ff00",
			},
			TelescopePromptTitle = {
				fg = "#dddddd",
				bg = "#000000",
			},
			TelescopePreviewBorder = {
				fg = "#ff00ff",
			},
			TelescopePreviewTitle = {
				fg = "#ff00f0",
				bg = "#000000",
			},
			TelescopeResultsBorder = {
				fg = "#0000ff",
			},
			TelescopeResultsTitle = {
				fg = "#000fff",
				bg = "#000000",
			},
			TelescopeSelectionCaret = {
				fg = "#D79921",
				bold = true,
			},
			TelescopeSelection = {
				fg = "#D79921",
				bold = true,
			},
		}
		for hl, col in pairs(TelescopePrompt) do
			vim.api.nvim_set_hl(0, hl, col)
		end

		telescope.load_extension("fzf")
	end,

	keys = {
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
		{ "<leader>fb", ":Telescope buffers<cr>" },
		{ "<leader>bf", ":Telescope current_buffer_fuzzy_find<cr>" },
		{ "<leader>o", ":Telescope lsp_outgoing_calls<cr>" },
	},
}

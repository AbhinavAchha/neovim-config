--   פּ ﯟ   some other good icons
-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"L3MON4D3/LuaSnip",
	},

	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- local check_backspace = function()
		-- 	local col = vim.fn.col(".") - 1
		-- 	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		-- end

		return {
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.sort_text,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.kind,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = {
				["<Tab>"] = cmp.mapping(function(fallback) --fallback
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<UP>"] = cmp.mapping.select_prev_item(),
				["<DOWN>"] = cmp.mapping.select_next_item(),
				-- Accept currently selected item. If none selected, `select` first item.
				-- Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			},
			formatting = {
				-- fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- Kind icons
					-- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
					vim_item.kind = " " .. (kind_icons[vim_item.kind] or "?") .. " "
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						nvim_lua = "[LUA]",
						luasnip = "[SNIP]",
						buffer = "[BUF]",
						path = "[FILE]",
						nvim_git = "[GIT]",
					})[entry.source.name]

					-- local item = entry:get_completion_item()
					--
					-- if item.detail then
					-- 	vim_item.kind = item.detail .. " " .. vim_item.kind
					-- end
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "git" },
				{ name = "buffer", keyword_length = 3 },
				{ name = "nvim_lsp_signature_help" },
			}),
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				completion = {
					border = "double",
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat,Normal:Pmenu,NormalNC:Pmenu,CursorLine:PmenuSel,StatusLine:NormalFloat,StatusLineNC:NormalFloat",
					side_padding = 1,
					-- col_offset = -5,
				},
			},
		}
	end,
}

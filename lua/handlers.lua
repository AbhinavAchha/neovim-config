-- 1) Consistent float styling
local bg = "#1e1e2e"
local border = "#5e81ac"

vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = border, bg = bg })
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

-- 2) Make markdown inside hovers not look sad
vim.g.markdown_fenced_languages = {
	"ts=typescript",
	"js=javascript",
	"json",
	"go",
	"rust",
	"c",
	"cpp",
	"lua",
	"python",
	"bash=sh",
}

-- 3) Nice default hover handler: border, wrap, title, sizes
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	max_width = math.floor(vim.o.columns * 0.45),
	max_height = math.floor(vim.o.lines * 0.35),
	focusable = true,
	title = " Hover ",
	title_pos = "center",
})

-- 4) Real padding: wrap open_floating_preview to add blank lines and defaults
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		opts.winhighlight = opts.winhighlight or "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
		opts.max_width = opts.max_width or math.floor(vim.o.columns * 0.45)
		opts.max_height = opts.max_height or math.floor(vim.o.lines * 0.35)
		opts.wrap = true

		-- Add padding left/right by prefixing spaces, plus top/bottom blank lines
		local pad_left = "  "
		local padded = { " " }
		for _, line in ipairs(contents) do
			table.insert(padded, pad_left .. line .. " ")
		end
		table.insert(padded, " ")

		return orig(padded, syntax, opts, ...)
	end
end

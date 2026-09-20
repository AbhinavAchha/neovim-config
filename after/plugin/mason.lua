local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end)

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"pyright",
		"ts_ls",
		"gopls",
		"clangd",
		"rust_analyzer",
		"tailwindcss",
		"cssls",
		"bashls",
		"dockerls",
		"yamlls",
		"html",
		"golangci_lint_ls",
		"zls",
	},
	handlers = {
		function(server)
			require("lspconfig")[server].setup({
				capabilities = capabilities,
			})
		end,
		["gopls"] = function()
			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})
		end,
	},
})

local function hover()
	vim.lsp.buf.hover({
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		max_width = math.floor(vim.o.columns * 0.45),
		max_height = math.floor(vim.o.lines * 0.35),
		focusable = true,
		title = " Hover ",
		title_pos = "center",
	})
end

local function diagnostic_jump(count)
	return function()
		vim.diagnostic.jump({
			count = count,
			on_jump = function(diagnostic, bufnr)
				if diagnostic then
					vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", border = "rounded" })
				end
			end,
		})
	end
end

-- global, dependable LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local buf = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buf = buf, silent = true, noremap = true, desc = desc })
		end

		-- don’t use "<cmd>lua ...<CR>" strings; bind the functions
		local cap = client.server_capabilities

		if cap.definitionProvider then
			map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
			map("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", "LSP: Go to declaration")
			map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
		end

		if cap.hoverProvider then
			map("n", "K", hover, "LSP: Hover")
		end

		if cap.referencesProvider then
			map("n", "gr", vim.lsp.buf.references, "LSP: References")
		end

		if cap.renameProvider then
			map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
		end

		if cap.codeActionProvider then
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
		end

		map("n", "gl", vim.diagnostic.open_float, "Diag: Line diagnostics")
		map("n", "[d", diagnostic_jump(-1), "Diag: Prev")
		map("n", "]d", diagnostic_jump(1), "Diag: Next")

		-- Breadcrumbs: attach navic when server supports documentSymbol
		local ok_navic, navic = pcall(require, "nvim-navic")
		if ok_navic and client.server_capabilities.documentSymbolProvider then
			navic.attach(client, buf)
		end
	end,
})

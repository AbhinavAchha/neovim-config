local handlers = require("handlers")
local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"pyright",
		"tsserver",
		"gopls",
		"eslint",
		"clangd",
		"rust_analyzer",
		"tailwindcss",
		"sqlls",
		"cssls",
		"bashls",
		"dockerls",
		"yamlls",
		"html",
		"golangci_lint_ls",
	},
})
handlers.setup()
require("completions")

local navic = require("nvim-navic")
local function on_attach(client, bufnr)
	handlers.on_attach(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
		codelenses = {
			generate = true,
			gc_details = true,
			test = true,
			tidy = true,
			upgrade_dependency = true,
			vendor = true,
		},
		hints = {
			constantValues = true,
		},
		gofumpt = true,
	},
})

lspconfig.golangci_lint_ls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = require("jsonls").settings,
	setup = require("jsonls").setup,
})

lspconfig.tsserver.setup({
	settings = {
		typescript = {
			tsserver = {
				trace = {
					server = "off",
				},
			},
		},
	},
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.dockerls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.sqlls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.tailwindcss.setup({
	on_attach = function(client, bufnr)
		require("tailwindcss-colors").buf_attach(bufnr)
		on_attach(client, bufnr)
	end,
	capabilities = handlers.capabilities,
	settings = {
		tailwindCss = {
			classAttributes = { "class", "className", "classes" },
		},
	},
})

lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})

-- -- Setup the LSP server to attach when you edit an sg:// buffer
-- require("sg").setup({
-- 	-- Pass your own custom attach function
-- 	--    If you do not pass your own attach function, then the following maps are provide:
-- 	--        - gd -> goto definition
-- 	--        - gr -> goto references
-- 	on_attach = on_attach,
-- })
-- vim.cmd([[nnoremap <space>sg <cmd>lua require('sg.telescope').fuzzy_search_results()<CR>]])

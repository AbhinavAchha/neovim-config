local handlers = require("handlers")
local lspconfig = require("lspconfig")

handlers.setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "sumneko_lua", "jsonls", "pyright", "tsserver", "gopls" },
})
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	handlers.on_attach(client, bufnr)
end

lspconfig.sumneko_lua.setup({
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
	},
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = require("jsonls").settings,
	setup = require("jsonls").setup,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
	settings = {
		typescript = {
			validate = {
				linting = false,
			},
		},
		javascript = {
			validate = {
				linting = false,
			},
		},
		document_formatting = false,
	},
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

lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = handlers.capabilities,
})
